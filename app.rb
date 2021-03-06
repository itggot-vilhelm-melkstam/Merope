require "rack-flash"
require "googleauth"

class App < Sinatra::Base
  enable :sessions
	use Rack::Flash

	before do
		if @no_cache
			cache_control :public, max_age: 0
			@no_cahce = false
		end
	end

  get "/" do
		if session[:user_id]
			@user = User.get(session[:user_id])
			redirect "/issues"
		else
  		slim :login, layout: false
		end
  end

	get "/issues" do
		if session[:user_id]
			@user = User.get(session[:user_id])
			@issues = Issue.all(user_id: @user.id)
			slim :issues
		else
			redirect "/"
		end
	end

	get "/issues/received" do
		if session[:user_id] && (User.get(session[:user_id]).rights == :admin)
			@user = User.get(session[:user_id])
			@issues = Issue.all
			slim :received_issues
		elsif session[:user_id]
			redirect "/"
		end
	end

	get "/issue/create" do
		@articles = []
		24.times { @articles << LoremIpsum.random.split(/ /)[0..rand(2..5)].join(" ")}
		@tags = Tag.all
		if session[:user_id]
			@user = User.get(session[:user_id])
			slim :create_issue
		else
			redirect "/"
		end
	end

  get "/issue/:id" do |id|
    if session[:user_id] && (session[:user_id] == Issue.get(id).user.id || User.get(session[:user_id]).rights == :admin)
      @user = User.get(session[:user_id])
      @issue = Issue.first(id: id)
      @status = {open: "ÖPPEN", closed: "STÄNGD", unassigned: "OTILLDELAD"}[@issue.status]
      @comments = Comment.all(issue: @issue)
      slim :issue
    else
      redirect "/"
    end
  end

	get "/oauth2callback" do
		client_secrets = Google::APIClient::ClientSecrets.load
  	auth_client = client_secrets.to_authorization
	end

  post "/issue/create" do
		flash[:notice] = []
    if session[:user_id]
			if params["tag"] == nil
				flash[:notice] << "Du har inte valt några taggar"
				redirect back
			end
      user = User.get(session[:user_id])
      issue = Issue.create(title: params["title"].chomp,
                           description: params["description"],
                           notice: params["notice"] == "t" ? true : false,
                           alternative_email: params["alternative_email"],
                           status: [:unassigned, :open, :closed].sample,
                           user_id: user.id)

			if issue
        begin
          if params["files"] != nil
    				params["files"].each do |file|
    					uuid = SecureRandom.hex
    					#File.open("public/files/#{uuid}.#{file[:filename].scan(/\.(.+)$/)[0]}") do |f|
    					File.open("./public/files/#{uuid}.#{file[:filename].scan(/\.(.+)$/)[0][0]}", "w+") do |f|
    						f.write file[:tempfile].read
    					end
    					Attachment.create(name: file[:filename],
    														path: "#{uuid}.#{file[:filename].scan(/\.(.+)$/)[0][0]}")
    				end
        end
        rescue
          issue.destroy
          flash[:notice] << "Kunde inte ladda upp filer"
        end

        begin
  	      params["tag"].each do |tag|
  	        Issuetagging.create(issue_id: issue.id, tag_id: tag.to_i)
  	      end
        rescue
          issue.destroy
          flash[:notice] << "Inga valda "
        end
			end

			flash[:notice] << "Ärende skapat" if issue

			@no_cache = true
      redirect "/issues"
    else
      redirect "/"
    end
  end

	post "/issue/:id/update" do |id|
		flash[:notice] = []
		if session[:user_id]
			@issue = Issue.get(id)
			@issue.update(notice: params["notice"] == "t" ? true : false, alternative_email: params["alternative_email"])
			flash[:notice] << "Ärendet uppdaterat"
			redirect "/issue/#{id}"
		end
	end

  post "/comment/create" do
    if session[:user_id]
			@user = User.get(session[:user_id])
      @issue = Issue.get(params["issue"].to_i)
      Comment.create(content: params["content"], issue: @issue, user: @user)
      redirect "/issue/#{@issue.id}"
		else
			redirect "/"
		end
  end

  post "/comment/delete" do
    flash[:notice] = []
    @user = User.get(session[:user_id])
    @comment = Comment.get(params["comment_id"].to_i)
    if session[:user_id] && @user == @comment.user
      @id = @comment.issue.id
      @comment.destroy
      redirect "/issue/#{@id}"
      flash[:notice] << "Kommentar borttagen"
    elsif session[:user_id]
      redirect back
    else
      redirect "/"
    end
  end

  post "/login" do
		user = User.first(email: params["email"])
    if user && user.password == params["password"]
      session[:user_id] = user.id
    end

    redirect "/issues"
  end

	post "/logout" do
		session.destroy
		redirect "/"
	end

  post "/register" do
		if params["password"] == params["password-repeat"]
			user = User.create(name: params["name"],
												 email: params["email"],
												 password: params["password"])
		end
    if user
      session[:user_id] = user.id
			redirect "/issues"
		else
			redirect "/"
		end
  end

end

class App < Sinatra::Base
  enable :sessions

  get '/' do
		if session[:user_id]
			@user = User.get(session[:user_id])
			redirect "/issues"
		else
  		slim :login, layout: false
		end
  end

	get '/issues' do
		if session[:user_id]
			@user = User.get(session[:user_id])
			@issues = Issue.all(user_id: @user.id)
			slim :issues
		else
			redirect "/"
		end
	end

	post "/logout" do
		session[:user_id] = nil
		redirect "/"
	end

  post "/login" do
		user = User.first(email: params["email"])
    if user && user.password == params["password"]
      session[:user_id] = user.id
    end
    redirect "/issues"
  end

  post "/register" do
		if params["password"] == params["password-repeat"]
			user = User.create(name: params["name"],
												 email: params["email"],
												 password: params["password"])
		end
    if user
      session[:user_id] = user.id
    end
    redirect "/issues"
  end


end

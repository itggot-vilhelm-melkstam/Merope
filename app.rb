class App < Sinatra::Base
  enable :sessions

  get '/' do
  	slim :login, layout: false
  end

	get '/issues' do
		@issues = Issue.all
		slim :issues
	end

	post "/logout" do
		redirect "/"
	end

  post "/login" do

  end

  post "/register" do
    
  end


end

class App < Sinatra::Base
  enable :sessions

  get '/' do
  	"Hello, Sinatra!"
  end

	get '/issues' do
		@issues = Issue.all
		slim :issues
	end


end

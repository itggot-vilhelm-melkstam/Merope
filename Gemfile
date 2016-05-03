# Tell bundler where to fetch gems
source 'https://rubygems.org'

# Tell heroku and bundler which version of ruby to use
ruby '2.2.3'

# Gems used by all environments (development, production & test)
gem 'sinatra'
gem 'sinatra-partial'
gem 'data_mapper'
gem 'dm-timestamps'
gem 'slim'
gem 'tilt', '~> 1.4.1' #temporary fix
gem 'racksh'
gem 'lorem_ipsum_amet'
gem 'rack-flash3'

# Used during local development (on your own machine)
group :development do

  # Use SQLite
  gem 'dm-sqlite-adapter', group: :development
  gem 'rerun', github: 'alexch/rerun'
  gem 'thin'

end

# Used during production (on Heroku), when your application is 'live'
group :production do

  # Use Postgresql
  # gem 'dm-postgres-adapter', group: :production Commented for now

end

# Used when running tests (rake test:[acceptance|models|routes])
group :test do

  gem 'rspec' # Use rspec to write tests
  gem 'capybara' # Use capybara to simulate a web browser (no javascript)
  gem 'selenium-webdriver' # Use selenium to programmatically control a web browser (javascript capable)

end

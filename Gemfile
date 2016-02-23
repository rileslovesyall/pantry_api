source 'https://rubygems.org'

# core sinatra gems
gem 'rack'
gem 'rake'
gem 'sinatra'
gem 'sinatra-contrib'

# database fun
gem 'sinatra-activerecord'
gem 'activerecord'
gem 'activemodel'

# to send json
gem 'json'

# for authentication
gem 'omniauth'
# gem 'omniauth-jwt'
gem 'omniauth-twitter'
gem 'bcrypt', '~> 3.1.2'
gem 'jwt'
gem 'warden'
# gem 'warden-jwt'
# gem 'sinatra-warden'

group :test do
  gem 'rspec'
  gem 'simplecov'
  gem "factory_girl", "~> 4.0"
end

group :development, :test do
  gem "faker"
  gem 'dotenv'
  gem 'shotgun'
  gem 'sqlite3'
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'pry'
  gem 'rake-notes'
end
source 'https://rubygems.org'
ruby '2.2.4'

# core sinatra gems
gem 'rack'
gem 'rake'
gem 'sinatra'
gem 'sinatra-contrib'
gem 'rack-cors'
gem 'thin'

# database fun
gem 'sinatra-activerecord'
gem 'activerecord'
gem 'activemodel'
gem 'pg'

# to send json
gem 'json'

# for authentication
gem 'omniauth'
gem 'omniauth-twitter'
gem 'bcrypt', '~> 3.1.2'
gem 'warden'

# For dem strong params
gem 'sinatra-strong-params'

# Amazon SDK / SES
gem 'aws-sdk', '~> 2'
gem 'aws-ses', "~> 0.6.0", :require => 'aws/ses'

# To set cron jobs
gem 'whenever'


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
  gem 'passenger', '~> 4.0.59'
end
  ENV["RACK_ENV"] ||= "development"

require 'bundler'
require 'erb'
require 'active_record'
require 'sinatra/base'
require 'sinatra/contrib/all'
require 'json'

Bundler.setup
Bundler.require(:default, ENV["RACK_ENV"].to_sym)

# Database
dbconfig = YAML.load(File.read('./config/database.yml'))
ActiveRecord::Base.establish_connection dbconfig["#{settings.environment}"]

# Require all app files

Dir["./app/**/*.rb"].each { |f| require f }

# Routes

# require_relative 'app/routes/foo'
# require_relative 'app/routes/users'

class PantryApp < Sinatra::Base

  set :root, File.dirname(__FILE__)

  enable :sessions

  # helpers Pantry::Helpers

  # register Pantry::Routing::Foo
  register Pantry::Routing::Users

end


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

configure :development do
  use BetterErrors::Middleware
  BetterErrors.application_root = __dir__
end

class PantryApp < Sinatra::Base

  set :root, File.dirname(__FILE__)
  enable :sessions

  register Sinatra::ActiveRecordExtension

  register Pantry::Controller::Users
  register Pantry::Controller::PantryItems
  register Pantry::Controller::Recipes

  get "/" do
    "Here's some stuff"
  end

end


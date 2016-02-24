  ENV["RACK_ENV"] ||= "development"

require 'bundler'
require 'erb'
require 'active_record'
require 'sinatra/base'
require 'sinatra/contrib/all'
require 'json'
require 'warden'

Bundler.setup
Bundler.require(:default, ENV["RACK_ENV"].to_sym)

# Database
dbconfig = YAML.load(File.read('./config/database.yml'))
ActiveRecord::Base.establish_connection dbconfig["#{settings.environment}"]

# Require all app files

Dir["./app/**/*.rb"].each { |f| require f }

class PantryApp < Sinatra::Base

  set :root, File.dirname(__FILE__)
  enable :sessions

  register Sinatra::ActiveRecordExtension
  # register Sinatra::Warden

  configure :development do
    use BetterErrors::Middleware
    BetterErrors.application_root = __dir__
  end

  # Configure Warden
  use Warden::Manager do |config|
      config.scope_defaults :default,
      # Set your authorization strategy
      strategies: [:access_token],
      # Route to redirect to when warden.authenticate! returns a false answer.
      action: '/unauthenticated'
      config.failure_app = self
  end

  Warden::Manager.before_failure do |env,opts|
      env['REQUEST_METHOD'] = 'POST'
  end

  # Implement your Warden stratagey to validate and authorize the access_token.
  Warden::Strategies.add(:access_token) do
      def valid?
          # Validate that the access token is properly formatted.
          request.env["HTTP_ACCESS_TOKEN"].is_a?(String)
      end

      def authenticate!
        access_granted = User.find_by(api_token: request.env["HTTP_ACCESS_TOKEN"])
        !access_granted ? fail!("Could not log in") : success!(access_granted)
      end

  end

  # ROUTES

  before do
    response.headers['Access-Control-Allow-Origin'] = '*' 
  end

  before '/*'  do
    unless params[:splat] == 'token'
      env['warden'].authenticate!(:access_token)
    end
  end

  before '/pantryitems/*' do
    unless request.post?
      p = PantryItem.find(params[:id])
    end
  end

  register Pantry::Controller::Users
  register Pantry::Controller::PantryItems
  register Pantry::Controller::Recipes
  register Pantry::Controller::Authentication

  get "/" do
    "maybe put some API docs here"
  end

  # This is the route that unauthorized requests gets redirected to.
  post '/unauthenticated' do
      content_type :json
      json({ message: "Sorry, this request can not be authenticated. Try again." })
  end

end


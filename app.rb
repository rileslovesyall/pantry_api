  ENV["RACK_ENV"] ||= "development"

require 'bundler'
require 'active_record'
require 'sinatra/base'
require 'sinatra/contrib/all'
require 'json'
require 'warden'
require 'sinatra/strong-params'
require 'securerandom'
require 'jwt'

require 'pry'
# PRY


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
  register Sinatra::StrongParams
  # register Sinatra::Warden

  # MIDDLEWARE

  # configure :development do
  #   use BetterErrors::Middleware
  #   BetterErrors.application_root = __dir__
  # end

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
          if !request.env["HTTP_AUTHORIZATION"].nil?
            request.env["HTTP_AUTHORIZATION"].slice(0..5) == 'pantry'
          else
            return false
          end
      end

      def authenticate!
        access_granted = User.find_by(api_token: request.env["HTTP_AUTHORIZATION"])
        !access_granted ? fail!("Could not log in") : success!(access_granted)
      end

  end

  # ROUTES ON ROUTES ON ROUTES

  before do
    response.headers['Access-Control-Allow-Origin'] = '*'
  end

  before '/api/v1/*'  do
    unless params[:splat] == 'token' || params[:splat] == 'unauthenticated'
      # if env['warden'].authenticate!(:access_token)
        @curr_user = env['warden'].authenticate!(:access_token)
      # end
    end
  end

  before '/api/v1/pantryitems/:id' do
      @p = PantryItem.find(params[:id])
  end

  register Pantry::Controller::Users
  register Pantry::Controller::PantryItems
  register Pantry::Controller::Recipes
  register Pantry::Controller::Authentication

  get "/" do
    return @curr_user.to_json
  end

  # This is the route that unauthorized requests gets redirected to.
  post '/unauthenticated' do
      content_type :json
      json({ message: "Sorry, this request can not be authenticated. Try again." })
  end

end


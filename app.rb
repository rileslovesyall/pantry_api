ENV["RACK_ENV"] ||= "development"

require 'rack/cors'
require 'bundler'
require 'active_record'
require 'sinatra/base'
require 'sinatra/contrib/all'
require 'json'
require 'warden'
require 'sinatra/strong-params'
# require 'pry'


Bundler.setup
Bundler.require(:default, ENV["RACK_ENV"].to_sym)

# DATABASE CONFIG
dbconfig = YAML.load(File.read('./config/database.yml'))
ActiveRecord::Base.establish_connection(ENV['DATABASE_URL'] || dbconfig["#{settings.environment}"])

# REQUIRE ALL APP FILES
Dir["./app/**/*.rb"].each { |f| require f }


class PantryAPI < Sinatra::Base

  set :root, File.dirname(__FILE__)
  enable :sessions

  configure :production, :development do
    enable :logging
  end

  #
  # HELPFUL EXTRA STUFF
  #

  register Sinatra::ActiveRecordExtension
  register Sinatra::StrongParams

  #
  # MIDDLEWARE
  #

  # 
  # RACK CORS MIDDLEWARE
  # 

  use Rack::Cors do
      allow do
        origins '*'
        resource '/*', :headers => :any, :methods => [:get, :post, :options, :put, :delete]
      end
  end

  configure :development do
    use BetterErrors::Middleware
    BetterErrors.application_root = __dir__
  end


  #
  # WARDEN MIDDLEWARE
  #

  use Warden::Manager do |config|
      config.scope_defaults :default,
      # set strategies
      strategies: [:access_token],

      # Route to redirect to when warden.authenticate! returns a false answer.
      action: '/unauthenticated'
      config.failure_app = self
  end

  Warden::Manager.before_failure do |env,opts|
      env['REQUEST_METHOD'] = 'POST'
  end

  Warden::Strategies.add(:access_token) do
      def valid?
        # binding.pry
          # Validate that the access token is properly formatted.
          if !request.env["HTTP_AUTHORIZATION"].nil?
            request.env["HTTP_AUTHORIZATION"].slice(0..5) == 'pantry'
          else
            return false
          end
      end

      def authenticate!
        # binding.pry
        access_granted = User.find_by(api_token: request.env["HTTP_AUTHORIZATION"])
        !access_granted ? fail!("Could not log in") : success!(access_granted)
      end

  end


  # 
  # HELPERS
  # 

  helpers do

    def requester_must_own_pantry_item
      if @curr_user != @p.user
        halt 401, {errors: "You are not authorized to make this request." }.to_json
      end
    end

    def requester_must_be_user
      if @curr_user != User.find(params[:id])
        halt 202, { errors: "You are not authorized to make this request." }.to_json
      end
    end

    def get_product(id)
      @p = PantryItem.find(id)
    end

    def get_user(id)
      @u = User.find(id)
    end

  end

  #
  # ROUTES ON ROUTES ON ROUTES
  #

  before do
    response.headers['Access-Control-Allow-Origin'] = '*'
    content_type :json
  end

  # dummy index route
  get "/" do
    "Hello, world."
    # turn into API docs?
  end

  get '/api/v1/health' do
    "Yep, I'm healthy."
  end


  before '/api/v1/*'  do
    unless params[:splat] == ['token'] || params[:splat] == ['unauthenticated'] || params[:splat] == ['users'] || params[:splat] == ['health'] 
        @curr_user = env['warden'].authenticate!(:access_token)
    end
  end

  register Pantry::Controller::Recipes
  register Pantry::Controller::Auth 

  before '/api/v1/pantryitems/:id' do
     get_product(params[:id])
  end

  register Pantry::Controller::PantryItems

  before '/api/v1/users/:id' do
    requester_must_be_user
    get_user(params[:id])
  end

  before '/api/v1/users/:id/*' do
    unless params[:splat] == 'public_pantry'
      requester_must_be_user
    end
  end

  register Pantry::Controller::Users

  #
  # UNAUTHENTICATED WARDEN ROUTE
  #

  post '/unauthenticated' do
      raise
      content_type :json
      json({ message: "Sorry, this request can not be authenticated. Try again." })
  end

end


module Pantry
  class Base < Sinatra::Base
    register Sinatra::Contrib

    configure do
      disable :run
      enable :sessions
      enable :method_override
      set :public_folder, "#{File.dirname(__FILE__)}/public"
    end

    configure :production do
      disable :logging
    end

    configure :development do
      enable :logging
      enable :show_exceptions
      set :session_secret, "wubalubbadubdub"
    end

    configure :test do
      enable :raise_errors
      disable :logging
      disable :reload_templates
    end

    get '/stylesheets/master.css' do
      scss :master
    end

    not_found do
      "Not Found"
    end

    error do
      "Error"
    end

  end
end
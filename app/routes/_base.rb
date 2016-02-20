module Pantry
  class Base < Sinatra::Base
    register Sinatra::Contrib

    configure do
      disable :run
      enable :sessions
      enable :method_override
      set :public_folder, "#{File.dirname(__FILE__)}/public"
      set :start_time, Time.now
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

    before do
     last_modified settings.start_time
     etag settings.start_time.to_s
     cache_control :public, :must_revalidate
    end

    not_found do
      "Not Found"
    end

    error do
      "Error"
    end

  end
end
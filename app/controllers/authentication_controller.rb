module Pantry
  module Controller
    module Authentication
      require 'pry'

      def self.registered(app)

        create = lambda do
          # write some code to see if user exists
          # return user token if it exists

        end

        authenticate_user do
          
        end

        app.post '/api/v1/token-auth', &create
        app.post '/api/v1/user_auth', &authenticate_user

      end
    end
  end
end
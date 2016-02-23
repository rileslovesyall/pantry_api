module Pantry
  module Controller
    module Authentication
      # TODO remove pry
      require 'securerandom'
      require 'pry'
      require 'jwt'

      def self.registered(app)

        create = lambda do
          fdsfsd
          # write some code to see if user exists
          # return user token if it exists
        end

        authenticate_user = lambda do
          response.headers['Access-Control-Allow-Origin'] = '*'
          user = User.find_by(email: params[:email])
          if user && user.authenticate(params[:password])
              api_token = SecureRandom.urlsafe_base64
              return user.to_json
          else
            return {errors: "Incorrect email or password."}.to_json
          end
        end

        token_refresh = lambda do
          # TO DO write token refresh method
        end

        app.post '/api/v1/token-auth', &create
        app.post '/api/v1/user_auth', &authenticate_user
        app.post '/api/v1/token-refresh/', &token_refresh

      end
    end
  end
end
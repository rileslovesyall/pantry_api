module Pantry
  module Controller
    module Authentication
      require 'pry'

      def self.registered(app)

        create = lambda do
          # write some code to see if user exists
          # return user token if it exists
        end

        authenticate_user = lambda do
          response.headers['Access-Control-Allow-Origin'] = '*'
          user = User.find_by(email: params[:email]).authenticate(params[:password])
          if user
            return user.to_json
          else
            return {errors: "Incorrect email or password."}.to_json
          end
        end

        app.post '/api/v1/token-auth', &create
        app.post '/api/v1/user_auth', &authenticate_user

      end
    end
  end
end
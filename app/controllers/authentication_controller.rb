module Pantry
  module Controller
    module Authentication
      # TODO remove pry
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
          binding.pry
          user = User.find_by(email: params[:email]).authenticate(params[:password])
          if user
            payload = {user: {email: user.email, name: user.name}}
            # RSA SIGNED TOKEN -- HOW TO PASS KEY?
            # rsa_private = OpenSSL::PKey::RSA.generate 2048
            # rsa_public = rsa_private.public_key
            # token = JWT.encode(payload, rsa_private, 'RS256')
            token = JWT.encode payload, nil, 'none'
            return token
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
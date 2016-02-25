module Pantry
  module Controller
    module Auth

      def self.registered(app)

        user_token = lambda do
          response.headers['Access-Control-Allow-Origin'] = '*'
          user = User.find_by(email: params[:email])
          if user && user.authenticate(params[:password])
              user.get_token
              response = {
                name: user.name,
                email: user.email,
                uid: user.id,
                token: user.api_token,
                message: "New API Token has been generated."
              }
              return response.to_json
          else
            return {errors: "Incorrect email or password."}.to_json
          end
        end

        token_refresh = lambda do
          # TO DO write token refresh method
          token = 'pantry' + SecureRandom.urlsafe_base64
          @curr_user.api_token = token
          @curr_user.save
          response = {
            status: success,
            token: @curr_user.api_token
          }
          return response.to_json
        end

        # app.post '/api/v1/token-auth', &create
        app.post '/api/v1/token', &user_token
        app.post '/api/v1/token-refresh/', &token_refresh

      end
    end
  end
end
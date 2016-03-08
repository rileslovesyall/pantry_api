module Pantry
  module Controller
    module Auth

      def self.registered(app)

        user_token = lambda do
          user = User.find_by(email: params[:email])
          if user && user.authenticate(params[:password])
              user.get_token
              info = {
                name: user.name,
                email: user.email,
                uid: user.id,
                token: user.api_token,
                message: "New API Token has been generated."
              }
              status 200
              content_type :json
              body info.to_json
              # binding.pry
              return
          else
            return {error: "Incorrect email or password."}.to_json
          end
        end

        token_refresh = lambda do
          @curr_user.get_token

          status 200
          return { token: @curr_user.api_token }.to_json
        end

        base = '/api/v1'
        app.post base + '/token', &user_token
        app.post base + '/token-refresh/', &token_refresh

      end
    end
  end
end
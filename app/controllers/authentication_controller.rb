module Pantry
  module Controller
    module Authentication

      def self.registered(app)

        create = lambda do
          # write some code to make a session
          # return user token if it exists 
        end

        app.post '/api/v1/token-auth', &create

      end
    end
  end
end
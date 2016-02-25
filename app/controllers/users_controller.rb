module Pantry
  module Controller
    module Users

      def self.registered(app)

        test_page = lambda do
          user = User.find(1)

          content_type :json
          user.to_json
        end

        public_pantry = lambda do
          p = User.find(params[:id]).public_pantry

          content_type :json
          p.to_json
        end

        app.get '/api/v1/users', &test_page
        app.get '/api/v1/users/:id/public_pantry', &public_pantry

      end
    end
  end
end
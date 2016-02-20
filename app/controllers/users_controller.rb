module Pantry
  module Controller
    module Users

      def self.registered(app)

        test_page = lambda do
          user = User.find(1)

          content_type :json
          user.to_json
        end

        user_pantry = lambda do
          p = User.find(params[:id]).pantry_items

          content_type :json
          p.to_json
        end

        app.get '/users', &test_page
        app.get '/users/:id/pantry', &user_pantry

      end
    end
  end
end
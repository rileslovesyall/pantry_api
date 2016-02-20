module Pantry
  module Controller
    module Users

      def self.registered(app)

        test_page = lambda do
          user = User.find(1)

          content_type :json
          user.to_json
        end

        app.get '/users', &test_page

      end
    end
  end
end
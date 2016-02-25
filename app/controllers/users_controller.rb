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

        pantry = lambda do
          # TODO write method
          # all pantry items 
        end

        prefix = '/api/v1/users'
        app.get prefix, &test_page
        app.get prefix + '/:id/public_pantry', &public_pantry
        app.get prefix + '/:id/pantry', &pantry

      end
    end
  end
end
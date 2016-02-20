module Pantry
  module Controller
    module PantryItems

      def self.registered(app)

        test_page = lambda do
          p = PantryItem.find(2)
          
          content_type :json
          p.to_json
        end

        show = lambda do
          p = PantryItem.find(params[:id])

          content_type :json
          p.to_json
        end

        app.get '/pantryitems', &test_page
        app.get '/pantryitems/:id', &show

      end
    end
  end
end
module Pantry
  module Controller
    module PantryItems

      def self.registered(app)

        index = lambda do
          p = PantryItem.all
          
          content_type :json
          p.to_json
        end

        show = lambda do
          p = PantryItem.find(params[:id])

          content_type :json
          p.to_json
        end

        app.get '/api/v1/pantryitems', &index
        app.get '/api/v1/pantryitems/:id', &show

      end
    end
  end
end
module Pantry
  module Controller
    module PantryItems

      def self.registered(app)

        test_page = lambda do
          p = PantryItem.find(1)
          
          content_type :json
          p.to_json
        end

        app.get '/', &test_page

      end
    end
  end
end
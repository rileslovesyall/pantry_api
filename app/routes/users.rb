module Pantry
  module Routing
    module Users

      def self.registered(app)

        test_page = lambda do
          content_type :json
          { :key1 => 'value1', :key2 => 'value2' }.to_json
        end

        app.get '/', &test_page

      end
    end
  end
end
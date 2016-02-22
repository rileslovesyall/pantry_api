module Pantry
  module Controller
    module Sessions

      def self.registered(app)

        test_page = lambda do
          "a thing"
        end

        app.get '/api/v1/session', &test_page

      end
    end
  end
end
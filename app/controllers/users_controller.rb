module Pantry
  module Controller
    module Users

      def self.registered(app)

        show = lambda do
          return @u.to_json(except: [:password_digest])
        end

        create = lambda do
          # TODO write method
        end

        update = lambda do
          # TODO write method
        end

        delete = lambda do
          # TODO write method
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

        base = '/api/v1/users'

        app.get base + '/:id/public_pantry', &public_pantry
        app.get base + '/:id/pantry', &pantry
        app.get base + '/:id', &show
        app.post base, &create
        app.patch base + '/:id', &update
        app.delete base + ':/id', &delete

      end
    end
  end
end
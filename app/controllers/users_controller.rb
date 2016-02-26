module Pantry
  module Controller
    module Users

      def self.registered(app)

        show = lambda do
          return @u.to_json(except: [:password_digest])
        end

        create = lambda do
          # TODO write method
          u = User.create(params)
          if u.save
            u.reload
            status 200
            return {
              message: "User has been created.",
              user: u
              }.to_json
          else
            status 400
            return {error: "There was a problem creating this user."}.to_json
          end
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

        private_pantry = lambda do
          # TODO write method
          # all pantry items 
        end

        base = '/api/v1/users'

        app.get base + '/:id/public_pantry', &public_pantry
        app.get base + '/:id/private_pantry', &private_pantry
        app.get base + '/:id', &show
        app.post base, allows: [:email, :password, :password_confirmation, :name] , &create
        app.post base + '/:id', &update
        app.delete base + ':/id', &delete

      end
    end
  end
end
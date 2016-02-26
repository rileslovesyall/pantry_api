module Pantry
  module Controller
    module Users

      def self.registered(app)

        show = lambda do
          return @u.to_json(except: [:password_digest])
        end

        create = lambda do
          u = User.create(params)
          if u.save
            u.reload
            status 200
            return {
              message: "User has been created.",
              user: u
              }.to_json
          elsif !User.where(email: params['email']).nil?
            status 400 
            return {error: "A user with this e-mail address already exists."}.to_json
          else
            status 400
            return {error: "There was a problem creating this user."}.to_json
          end
        end

        update = lambda do
          @u.update(params)
          if @u.save
            status 200
            return {
              message: "Your user information has been updated.",
              user: {
                name: @u.name,
                email: @u.email
                }
              }.to_json
          else
            status 500
            return {error: "Something went wrong. Please try again."}.to_json
          end
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
        app.post base + '/:id', allows: [:email, :name], &update
        app.delete base + ':/id', &delete

      end
    end
  end
end
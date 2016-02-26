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
          begin
            @u.pantry_item_users.each do |pic|
              pic.delete
            end
            @u.delete
          rescue
            status 400
            return {error: "Something went wrong. Please try again."}.to_json
          end
          status 200
          return {message: "Your user profile has been deleted."}.to_json
        end

        public_pantry = lambda do
          p = @curr_user.public_pantry
          # binding.pry
          status 200
          return {pantry_items: p}.to_json
        end

        personal_pantry = lambda do
          requester_must_be_user
          p = @curr_user.personal_pantry
          status 200
          return {pantry_items: p}.to_json
        end

        private_pantry = lambda do
          requester_must_be_user
          p = @curr_user.private_pantry
          status 200
          return {pantry_items: p}.to_json
        end

        base = '/api/v1/users'

        app.get base + '/:id/public_pantry', &public_pantry
        app.get base + '/:id/personal_pantry', &personal_pantry
        app.get base + '/:id/private_pantry', &private_pantry
        app.get base + '/:id', &show
        app.post base, allows: [:email, :password, :password_confirmation, :name] , &create
        app.post base + '/:id', allows: [:email, :name], &update
        app.delete base + '/:id', &delete

      end
    end
  end
end
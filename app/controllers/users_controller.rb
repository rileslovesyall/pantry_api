module Pantry
  module Controller
    module Users

      if defined? Dotenv
        Dotenv.load
      end

      def self.registered(app)

        show = lambda do
          return @u.to_json(except: [:password_digest])
        end

        create = lambda do
          response.headers['Access-Control-Allow-Origin'] = '*'
          u = User.create(params)
          # binding.pry
          if u.save
            u.reload

            ses = AWS::SES::Base.new(
              :access_key_id => ENV['AWS_KEY'],
              :secret_access_key => ENV['AWS_SECRET'],
              :server => 'email.us-west-2.amazonaws.com'
            )
            ses.send_email(
              :to        => u.email,
              :source    => 'riley.r.spicer@gmail.com',
              :subject   => "Welcome to Pocket Pantry.",
              :html_body => "<h2>Welcome, #{u.name}.</h2> <p>You can start logging your pantry now by logging in at www.pocketpantry.org</p>"
            )
            status 200
            return {user: u}.to_json(except: [:password_digest])
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
              user: @u.to_json(except: [:password_digest])
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
          # binding.pry
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

        expiring_soon = lambda do
          requester_must_be_user
          exp = PantryItemsUser.expiring_soon(@curr_user.id)
          status 200
          return {expiring: exp}.to_json
        end



        base = '/api/v1/users'

        app.post base, allows: [:email, :password, :password_confirmation, :name] , &create
        app.get base + '/:id/public_pantry', &public_pantry
        app.get base + '/:id/personal_pantry', &personal_pantry
        app.get base + '/:id/private_pantry', &private_pantry
        app.get base + '/:id/expiring_soon', &expiring_soon
        app.get base + '/:id', &show
        app.post base + '/:id', allows: [:email, :name, :exp_pref], &update
        app.delete base + '/:id', &delete

      end
    end
  end
end
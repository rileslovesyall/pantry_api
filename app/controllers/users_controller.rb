module Pantry
  module Controller
    module Users

      if defined? Dotenv
        Dotenv.load
      end

      def self.registered(app)

        show = lambda do
          # binding.pry
          return @u.to_json(except: [:password_digest])
        end

        create = lambda do
          response.headers['Access-Control-Allow-Origin'] = '*'
          u = User.create(params)
          if u.save
            u.reload

            ses = AWS::SES::Base.new(
              :access_key_id => ENV['AWS_KEY'],
              :secret_access_key => ENV['AWS_SECRET'],
              :server => 'email.us-west-2.amazonaws.com'
            )
            ses.send_email(
              :to        => u.email,
              :source    => '"Pocket Pantry" <riley.r.spicer@gmail.com>',
              :subject   => "Welcome to Pocket Pantry.",
              :html_body => "<h2>Welcome, #{u.name}.</h2> <p>You can start logging your pantry now by logging in at www.pocketpantry.org</p>"
            )
            status 200
            return {user: u}.to_json(except: [:password_digest])
          elsif !User.where(email: params['email']).nil?
            # status 400 
            return {error: "A user with this e-mail address already exists."}.to_json
          else
            status 400
            return {error: "There was a problem creating this user."}.to_json
          end
        end

        update = lambda do
          if params['exp_soon_units'] == 'days'
            params['exp_soon_days'] = params['exp_soon_quant'].to_i
          elsif params['exp_soon_units'] == 'weeks'
            params['exp_soon_days'] = params['exp_soon_quant'].to_i * 7
          end
          params.delete('exp_soon_quant')
          params.delete('exp_soon_units')
          @u.update(params)
          if @u.save
            updateHTML = "<h1>Your Updated Account Information:</h1>"
            updateHTML += "<div>Name: #{@u.name}</div>" +
              "<div>Email: #{@u.email}</div>" +
              "<div>Expiration Notifications: #{@u.exp_notif}</div>" +
              "<div>Expiring Soon Setting: #{@u.nice_exp}</div>" +
              "<p> If you did not intend to make these changes, please log in at <a href='www.pocketpantry.org'>Pocket Pantry</a> to adjust these changes.</p>" +
              "Cheers, <br> The Pocket Pantry Team"
            ses = AWS::SES::Base.new(
              :access_key_id => ENV['AWS_KEY'],
              :secret_access_key => ENV['AWS_SECRET'],
              :server => 'email.us-west-2.amazonaws.com'
            )
            ses.send_email(
              :to        => @u.email,
              :source    => '"Pocket Pantry" <riley.r.spicer@gmail.com>',
              :subject   => "Your Account Has Been Updated.",
              :html_body => updateHTML
            )
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

        consumed_pantry = lambda do
          requester_must_be_user
          p = @curr_user.consumed_pantry
          status 200
          return {pantry_items: p}.to_json
        end

        expiring_soon = lambda do
          requester_must_be_user
          exp = PantryItemsUser.expiring_soon(@curr_user.id)
          exp_items = []
          exp.each do |e|
            item = {}
            pantry_item = PantryItem.find(e['pantry_item_id'].to_i)
            item['id'] = pantry_item.id
            item['name'] = pantry_item.name
            item['portion'] = pantry_item.portion
            item['quantity'] = e.quantity
            item['exp_date'] = e.exp_date.to_date
            exp_items << item
          end
          status 200
          return exp_items.to_json
        end



        base = '/api/v1/users'

        app.post base, allows: [:email, :password, :password_confirmation, :name] , &create
        app.get base + '/:id/public_pantry', &public_pantry
        app.get base + '/:id/personal_pantry', &personal_pantry
        app.get base + '/:id/private_pantry', &private_pantry
        app.get base + '/:id/out-of-stock', &consumed_pantry
        app.get base + '/:id/expiring_soon', &expiring_soon
        app.get base + '/:id', &show
        app.post base + '/:id', allows: [:email, :name, :exp_notif, :exp_soon_quant, :exp_soon_units], &update
        app.delete base + '/:id', &delete

      end
    end
  end
end
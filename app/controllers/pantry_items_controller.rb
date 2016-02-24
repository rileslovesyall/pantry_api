module Pantry
  module Controller
    module PantryItems

      def self.registered(app)

        index = lambda do
          p = PantryItem.all
          content_type :json
          body 
            {pantryitems: p}.to_json
        end

        show = lambda do
          content_type :json
          body 
            {pantryitem: @p}.to_json
        end

        create = lambda do
          p = PantryItem.create({
            name: params["name"],
            description: params["description"],
            quantity: params["quantity"],
            user_id: @curr_user.id
            })
          if p.save
            content_type :json
          body 
            {message: "Your item has been created",  status: 200}.to_json
          else
            # TODO update status codes here
            {errors: "Something went wrong, please try again."}.to_json
          end

        end

        update = lambda do
          # TODO write pantryitem update method
          # params.each do |key, value|
          #   p.key = value
          # end
          # if p.save
          #   content_type :json
          # body 
          #   {message: "Your item has been updated!",  status: 200}.to_json
          # else
          #   # TODO update status codes here
          #   {errors: "Something went wrong, please try again."}.to_json
          # end
          return params.to_json
        end

        delete = lambda do
          # TODO write pantryitem delete method
        end

        app.get '/api/v1/pantryitems', &index
        app.get '/api/v1/pantryitems/:id', &show
        app.post '/api/v1/pantryitems', &create
        app.patch '/api/v1/pantryitems/:id', &update
        app.delete '/api/v1/pantryitems/:id', &delete

      end
    end
  end
end
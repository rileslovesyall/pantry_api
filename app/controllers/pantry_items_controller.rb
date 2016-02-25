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
          if @curr_user != @p.user
            response = {
              errors: "You are not authorized to make this request."
            }
            return response.to_json
          else
            @p.update(params)
            if @p.save
              response = {
                message: "Your item as been updated."
              }
              return response.to_json
            else
              response = {
                errors: "There was a mistake. Please try again."
              }
              return response.to_json
            end
          end
        end

        delete = lambda do
          if @curr_user != @p.user
            response = {
              errors: "You are not authorized to make this request."
            }
            return response.to_json
          else
            @p.delete
            @p.pantry_item_categories.each do |pic|
              pic.delete
            end
            response = {
              message: "Your item has been deleted."
            }
            return response.to_json
          end
        end

        base = '/api/v1/pantryitems'

        app.get base, &index
        app.get base + '/:id', &show
        app.post base, &create
        app.patch base + '/:id', allows: [:name, :description, :quantity], &update
        app.delete base + '/:id', &delete

      end
    end
  end
end
module Pantry
  module Controller
    module PantryItems

      def self.registered(app)

        index = lambda do
          p = PantryItem.all
          content_type :json
          status 200
          body 
            {pantryitems: p}.to_json
        end

        show = lambda do
          content_type :json
          status 200
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
            status 200
          body 
            {message: "Your item has been created"}.to_json
          else
            # TODO update status codes here
            status 400
            {errors: "Something went wrong, please try again."}.to_json
          end

        end

        update = lambda do
          if @curr_user != @p.user
            response = {
              errors: "You are not authorized to make this request."
            }
            status 401
            body response.to_json
          else
            @p.update(params)
            if @p.save
              response = {
                message: "Your item as been updated.",
                pantryitem: @p
              }
              body response.to_json
            else
              response = {
                errors: "There was a mistake. Please try again."
              }
              status 400
              body response.to_json
            end
          end
        end

        delete = lambda do
          if @curr_user != @p.user
            response = {
              errors: "You are not authorized to make this request."
            }
            status 401
            body response.to_json
          else
            @p.delete
            @p.pantry_item_categories.each do |pic|
              pic.delete
            end
            status 200
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
        app.patch base + '/:id', 
          allows: [:name, :description, :quantity, :consumed_at, :consumed, :expiration_date, :show_public], 
          &update
        app.delete base + '/:id', &delete

      end
    end
  end
end
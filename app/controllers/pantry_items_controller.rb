module Pantry
  module Controller
    module PantryItems

      def self.registered(app)

        # NOT WORKING
        

        index = lambda do
          p = PantryItem.all
          content_type :json
          status 200
          body 
            {pantryitems: p}.to_json
        end

        show = lambda do
          if !@p.show_public
            requester_must_own_resource
          end
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
          requester_must_own_resource
          # get_product(params[:id])
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

        delete = lambda do
          requester_must_own_resource
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

        consume = lambda do
          get_product(params['id'])
          if @curr_user != @p.user
            status 401
            return { errors: "You are not authorized to make this request." }
          end
          begin
            PantryItemUser.create({
              user_id: @curr_user.id,
              pantry_item_id: @p.id,
              quantity: params["quantity"],
              action: 'consume'
              })
          rescue
            status 400
            return {
              error: "You don't have any of this item to consume.",
              quantity: @p.quantity
              }.to_json
          end
          status 200
          @p.reload
          return {
            message: "Your consumption was successful.",
            new_quantity: @p.quantity
          }.to_json
        end

        base = '/api/v1/pantryitems'

        app.get base, &index
        app.get base + '/:id', &show
        app.post base, &create
        app.post base + '/:id', allows: [:id, :name, :description, :expiration_date, :show_public], &update
        app.delete base + '/:id', &delete
        app.post base + '/:id/consume', allows: [:quantity, :id], &consume

      end
    end
  end
end
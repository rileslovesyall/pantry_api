module Pantry
  module Controller
    module PantryItems

      def self.registered(app)

        # NOT WORKING
        

        index = lambda do
          # TODO update this method
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
            return {message: "Your item has been created"}.to_json
          else
            # TODO update status codes here
            status 400
            return {errors: "Something went wrong, please try again."}.to_json
          end

        end

        update = lambda do
          requester_must_own_resource
          @p.update(params)
          if @p.save
            return {
              message: "Your item as been updated.",
              pantryitem: @p
            }.to_json
          else
            status 400
            return {errors: "There was a mistake. Please try again."}.to_json
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
          requester_must_own_resource
          if params['quantity'].nil?
            status 400
            return {error: "You must provide a quantity."}.to_json
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
              pantryitem: @p
              }.to_json
          end
          status 200
          @p.reload
          return {
            message: "Your consumption was successful.",
            pantryitem: @p
          }.to_json
        end

        add = lambda do
          get_product(params['id'])
          requester_must_own_resource
          if params['quantity'].nil?
            status 40
            return {error: "You must provide a quantity."}.to_json
          end
          add = PantryItemUser.create({
            user_id: @curr_user,
            pantry_item_id: @p.id,
            quantity: params['quantity'],
            action: 'add'
            })
          if add
            status 200
            @p.reload
            return {
              message: "Addition was a success.",
              pantryitem: @p
            }.to_json
          else
            status 400
            return {error: "Something went wrong. Please try again."}
          end
        end

        base = '/api/v1/pantryitems'

        app.get base, &index
        app.get base + '/:id', &show
        app.post base, &create
        app.post base + '/:id', allows: [:name, :description, :expiration_date, :show_public], &update
        app.delete base + '/:id', &delete
        app.post base + '/:id/consume', allows: [:quantity, :id], &consume
        app.post base + '/:id/add', allows: [:quantity, :id], &add

      end
    end
  end
end
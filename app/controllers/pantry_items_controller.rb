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
            requester_must_own_pantry_item
          end
          content_type :json
          status 200
          body 
            {
              pantryitem: @p,
              ingredients: @p.ingredients
            }.to_json
        end

        create = lambda do
          ingredients = params['ingredients'].split(',')
          params.delete('ingredients')
          exp_time = params['time-to-exp']
          params.delete('time-to-exp')
          exp_unit = params['exp-unit']
          params.delete('exp-unit')
          p = PantryItem.new(params)
          p.user = @curr_user
          ingredients.each do |ing|
            i = Ingredient.find_or_create({name: ing})
            p.ingredients << i
          end
          p.days_to_exp = exp_to_days(exp_time, exp_unit)
          p.save
          if p.save
            status 200 
            return {
              message: "Your item has been created",
              pantryitem: p
              }.to_json
          else
            status 500
            return {error: "Something went wrong, please try again."}.to_json
          end

        end

        update = lambda do
          requester_must_own_pantry_item
          ingredients = params['ingredients'].split(',')
          params.delete('ingredients')
          @p.update(params)
          ingredients.each do |ing|
            i = Ingredient.find_or_create({name: ing})
            if !@p.ingredients.include?(i)
              @p.ingredients << i
            end
          end
          if @p.save
            return {
              message: "Your item as been updated.",
              pantryitem: @p,
              ingredients: @p.ingredients
            }.to_json
          else
            status 500
            return {errors: "There was a mistake. Please try again."}.to_json
          end
        end

        delete = lambda do
          requester_must_own_pantry_item
          begin
            @p.pantry_item_categories.each do |pic|
              pic.delete
            end
            @p.pantry_items_users.each do |piu|
              piu.delete
            end
            @p.delete
          rescue
            status 500
            return {error: "Something went wrong. Please try again."}.to_json
          end
          status 200
          response = {
            message: "Your item has been deleted."
          }
          return response.to_json
        end

        consume = lambda do
          get_product(params['id'])
          requester_must_own_pantry_item
          if params['quantity'].nil?
            status 500
            return {error: "You must provide a quantity."}.to_json
          end
          begin
            PantryItemsUserLog.create({
              user_id: @curr_user.id,
              pantry_item_id: @p.id,
              quantity: params["quantity"],
              action: 'consume'
              })
          rescue
            # status 400
            return {
              error: "You don't have enough of this item to consume.",
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
          requester_must_own_pantry_item
          if params['quantity'].nil?
            status 500
            return {error: "You must provide a quantity."}.to_json
          end
          add = PantryItemsUserLog.create({
            user_id: @curr_user.id,
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
            # status 400
            return {error: "Something went wrong. Please try again."}
          end
        end

        base = '/api/v1/pantryitems'

        app.get base, &index
        app.get base + '/:id', &show
        app.post base, allows: [:name, :quantity, :description, :expiration_date, :show_public, :portion, :ingredients, 'time-to-exp', 'exp-unit'], &create
        app.post base + '/:id', allows: [:name, :description, :expiration_date, :show_public, :portion, :ingredients], &update
        app.delete base + '/:id', &delete
        app.post base + '/:id/consume', allows: [:quantity, :id], &consume
        app.post base + '/:id/add', allows: [:quantity, :id], &add



      end
    end
  end
end
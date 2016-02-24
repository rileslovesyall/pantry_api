module Pantry
  module Controller
    module PantryItems

      def self.registered(app)

        index = lambda do
          p = PantryItem.all
          response.headers['Access-Control-Allow-Origin'] = '*' 
          content_type :json
          body 
            {pantryitems: p}.to_json
        end

        show = lambda do
          response.headers['Access-Control-Allow-Origin'] = '*' 
          content_type :json
          body 
            {pantryitem: p}.to_json
        end

        create = lambda do
          PantryItem.create({
            name: params[:name],
            description: params[:description]
            })
        end

        update = lambda do
          
        end

        delete = lambda do
          
        end

        app.get '/api/v1/pantryitems', &index
        app.get '/api/v1/pantryitems/:id', &show
        app.post '/api/v1/pantryitems/:id', &create
        app.patch '/api/v1/pantryitems/:id', &update
        app.delete '/api/v1/pantryitems/:id', &delete

      end
    end
  end
end
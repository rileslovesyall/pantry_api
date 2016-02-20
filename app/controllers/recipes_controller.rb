module Pantry
  module Controller
    module Recipes

      def self.registered(app)

        index = lambda do
          recipes = Recipe.all

          content_type :json
          recipes.to_json
        end

        show = lambda do 
          recipe = Recipe.find(params[:id])

          content_type :json
          recipe.to_json
        end

        ingredients = lambda do
          ingredients = Recipe.find(params[:id]).ingredients

          content_type :json
          ingredients.to_json
        end

        app.get '/recipes', &index
        app.get '/recipes/:id', &show
        app.get '/recipes/:id/ingredients', &ingredients

      end
    end
  end
end
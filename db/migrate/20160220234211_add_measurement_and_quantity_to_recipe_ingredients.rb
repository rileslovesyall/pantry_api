class AddMeasurementAndQuantityToRecipeIngredients < ActiveRecord::Migration
  def change
    add_column(:recipe_ingredients, :quantity, :integer)
    add_column(:recipe_ingredients, :measurement, :string)
  end
end

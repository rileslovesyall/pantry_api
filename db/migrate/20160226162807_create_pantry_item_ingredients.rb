class CreatePantryItemIngredients < ActiveRecord::Migration
  def change
    create_table :pantry_item_ingredients do |t|
      t.integer :pantry_item_id
      t.integer :ingredient_id
      t.string :measurement
      t.integer :quantity
    end
  end
end

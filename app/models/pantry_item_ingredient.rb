class PantryItemIngredient < ActiveRecord::Base
  belongs_to :pantry_item
  belongs_to :ingredient

end
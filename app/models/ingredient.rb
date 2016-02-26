class Ingredient < ActiveRecord::Base
  has_many :recipe_ingredients
  has_many :recipes, through: :recipe_ingredients
  has_many :pantry_item_ingredients
  has_many :pantry_items, through: :pantry_item_ingredients

  validates_presence_of :name
  validates_uniqueness_of :name

end
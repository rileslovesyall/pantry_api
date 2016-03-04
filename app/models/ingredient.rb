class Ingredient < ActiveRecord::Base
  has_many :recipe_ingredients
  has_many :recipes, through: :recipe_ingredients
  has_many :pantry_item_ingredients
  has_many :pantry_items, through: :pantry_item_ingredients

  validates_presence_of :name
  validates_uniqueness_of :name

  def self.find_or_create(ing_hash)
    i = Ingredient.find_by(name: ing_hash[:name])
    if i
      return i
    else
      ing = Ingredient.create(ing_hash)
      if ing
        return ing
      else
        # TODO update this error type
        raise "There was an error creating this ingredient."
      end
    end
  end

end
class PantryItem < ActiveRecord::Base
  belongs_to :user
  has_many :pantry_item_ingredients
  has_many :ingredients, through: :pantry_item_ingredients
  has_many :pantry_item_users
  has_many :pantry_item_categories
  has_many :categories, through: :pantry_item_categories

  validates_presence_of :name, :quantity

  after_create :create_pantry_item_user

  def set_expiration_email
    # TODO add code here
  end

  def self.public
    return self.where(show_public: true, consumed: false)
  end

  # 
  # TODO figure out how to add ingredients on creation of pantryitem
  #   
  # def add_ingredients(ing_arr)
  #   puts ing_arr
  #   ing_arr.split(",").each do |ing_hash_str|
  #     ing = JSON.parse(ing_hash_str.to_json)
  #     i = Ingredient.create(ing)
  #     self.ingredients.push(i)
  #   end
  # end

  # def update_ingredients(ing_arr)
  #   ing_arr.split(",").each do |ing|
  #     i = Ingredient.create(name: ing)
  #     self.ingredients.push(i) if self.ingredients
  #   end
  # end

  private

  def create_pantry_item_user
    p = PantryItemUser.create({
      pantry_item_id: self.user.id,
      user_id: id,
      action: 'init',
      quantity: self.quantity
      })
    p.save
  end

end
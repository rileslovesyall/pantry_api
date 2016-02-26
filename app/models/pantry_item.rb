class PantryItem < ActiveRecord::Base
  belongs_to :user
  has_many :ingredients
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

  def add_ingredients(ing_arr)
    
  end

  private

  def create_pantry_item_user
    p = PantryItemUser.create({
      pantry_item_id: self.id,
      user_id: self.user.id,
      action: 'init',
      quantity: self.quantity
      })
    p.save
  end

end
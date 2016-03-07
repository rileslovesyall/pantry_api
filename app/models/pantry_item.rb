class PantryItem < ActiveRecord::Base
  belongs_to :user
  has_many :pantry_item_ingredients
  has_many :ingredients, through: :pantry_item_ingredients
  has_many :pantry_items_user_logs
  has_many :pantry_item_categories
  has_many :categories, through: :pantry_item_categories

  validates_presence_of :name, :quantity

  after_create :create_pantry_item_user

  def self.public
    return self.where(show_public: true, consumed: false)
  end

  private

  def create_pantry_item_user
    p = PantryItemsUserLog.create({
      pantry_item_id: self.id,
      user_id: self.user.id,
      action: 'init',
      quantity: self.quantity
      })
    p.save
  end

end
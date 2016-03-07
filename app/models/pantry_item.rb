class PantryItem < ActiveRecord::Base
  belongs_to :user
  has_many :pantry_item_ingredients
  has_many :ingredients, through: :pantry_item_ingredients
  has_many :pantry_items_user_logs
  has_many :pantry_item_categories
  has_many :categories, through: :pantry_item_categories

  validates_presence_of :name, :quantity

  after_create :create_log, :create_exp_join

  def self.public
    return self.where(show_public: true, consumed: false)
  end

  private

  def create_log
    p = PantryItemsUserLog.create({
      pantry_item_id: self.id,
      user_id: self.user.id,
      action: 'init',
      quantity: self.quantity
      })
    p.save
  end

  def create_exp_join
    exp = DateTime.now + (self.days_to_exp).to_i
    p = PantryItemsUser.create({
      pantry_item_id: self.id,
      user_id: self.user.id,
      quantity: self.quantity,
      exp_date: exp
      })
    p.save
  end

end
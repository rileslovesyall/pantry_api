class PantryItem < ActiveRecord::Base
  belongs_to :user
  has_many :pantry_item_categories
  has_many :categories, through: :pantry_item_categories

  validates_presence_of :name, :quantity, :user_id

end
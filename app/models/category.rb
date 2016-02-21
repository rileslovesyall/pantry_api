class Category < ActiveRecord::Base
  has_many :pantry_item_categories
  has_many :pantry_items, through: :pantry_item_categories

end
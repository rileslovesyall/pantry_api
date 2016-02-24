class PantryItemCategory < ActiveRecord::Base
  belongs_to :category 
  belongs_to :pantry_item
end
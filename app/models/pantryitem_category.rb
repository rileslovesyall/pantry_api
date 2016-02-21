class PantryItemCategory < ActiveRecord::Base
  belongs_to :pantry_item 
  belongs_to :category
end
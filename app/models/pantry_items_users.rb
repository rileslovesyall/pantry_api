class PantryItemsUsers < ActiveRecord::Base
  belongs_to :pantry_item
  belongs_to :user

end
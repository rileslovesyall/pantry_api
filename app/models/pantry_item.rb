class PantryItem < ActiveRecord::Base
  belongs_to :user
  validates_presence_of :name, :quantity, :user_id

end
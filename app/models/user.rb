class User < ActiveRecord::Base
  has_many :pantry_items
  has_many :recipes

  validates_presence_of :email
  validates_uniqueness_of :email

end
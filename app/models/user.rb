class User < ActiveRecord::Base
  has_many :pantry_items

  validates_presence_of :email
  validates_uniqueness_of :email

end
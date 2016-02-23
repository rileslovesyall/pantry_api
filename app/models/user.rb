class User < ActiveRecord::Base
  include BCrypt  
  has_many :pantry_items
  has_many :recipes

  has_secure_password

  validates_presence_of :email
  validates_uniqueness_of :email

  

end
class User < ActiveRecord::Base
  has_many :pantryitems
  
  validates_presence_of :email

end
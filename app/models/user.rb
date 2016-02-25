class User < ActiveRecord::Base
  include BCrypt  
  has_many :pantry_items
  has_many :recipes

  has_secure_password

  validates_presence_of :email
  validates_uniqueness_of :email

  def add_uid
    # TODO add code here
  end

  def public_pantry
    self.pantry_items.where(public: true, consumed: false)
  end

  def private_pantry
    self.pantry_items.where(public: false)
  end

  def method_name
    
  end

end
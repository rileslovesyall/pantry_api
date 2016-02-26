require 'securerandom'

class User < ActiveRecord::Base
  include BCrypt  
  has_many :pantry_items
  has_many :recipes
  has_many :pantry_item_users

  has_secure_password

  validates_presence_of :email
  validates_uniqueness_of :email
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, :on => :create

  before_create :get_token

  def get_token
    token = 'pantry' + SecureRandom.urlsafe_base64
    self.api_token = token
  end

  def pantry
    self.pantry_items.where(consumed: false)
  end

  def public_pantry
    self.pantry_items.where('show_public = true AND quantity >= 0')
  end

  def private_pantry
    self.pantry_items.where(show_public: false, consumed: false)
  end

  def consumed_pantry
    self.pantry_items.where(consumed: true)
  end

end
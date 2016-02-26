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
    # TODO REMOVE THIS DON'T FORGET
    unless self.email == 'rick@tinyrick.com'
      token = 'pantry' + SecureRandom.urlsafe_base64
      self.api_token = token
    end
  end

  def personal_pantry
    self.pantry_items.where('quantity >= 0')
  end

  def public_pantry
    self.pantry_items.where('show_public = ? AND quantity >= ?', true, 0)
  end

  def private_pantry
    self.pantry_items.where('show_public = ? AND quantity >= ?', false, 0)
  end

  def consumed_pantry
    # TODO make this a thing
  end

end
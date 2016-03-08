require 'securerandom'

class User < ActiveRecord::Base
  include BCrypt  
  has_many :pantry_items
  has_many :recipes
  has_many :pantry_items_user_logs

  has_secure_password

  validates_presence_of :email
  validates_uniqueness_of :email
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, :on => :create

  after_create :get_token

  def get_token
    # TODO REMOVE THIS DON'T FORGET
    unless self.email == 'rick@tinyrick.com'
      token = 'pantry' + SecureRandom.urlsafe_base64
      self.api_token = token
      self.save
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

  def self.send_expiration_emails
    ses = AWS::SES::Base.new(
      :access_key_id => ENV['AWS_KEY'],
      :secret_access_key => ENV['AWS_SECRET'],
      :server => 'email.us-west-2.amazonaws.com'
    )
    self.where(exp_notif: true).each do |user|
      exp_soon = PantryItemsUser.expiring_soon(user.id)
      exp_html = "<h1>Here's what need to get eaten:</h1>"
      exp_html += "<ul>"
      if exp_soon.length > 0
        exp_soon.each do |exp_item|
          item = exp_item.pantry_item
          exp_html += "<li>#{item.quantity} #{item.portion}(s) of #{item.name}</li>"
        end
        exp_html += "</ul>"
        exp_html += "<p>Make something delicious with your food before it goes bad! And remember, you can check out your list of what's expiring soon after you log in to <a href='www.pocketpantry.com'>Pocket Pantry</a>!</p>"
        exp_html += "Happy Eating, from the Pocket Pantry team."
        ses.send_email(
          :to        => user.email,
          :source    => '"Pocket Pantry" <riley.r.spicer@gmail.com>',
          :subject   => "You have items expiring soon!",
          :html_body => exp_html
        )
      end
    end
  end


end
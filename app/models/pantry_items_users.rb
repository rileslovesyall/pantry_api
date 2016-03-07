require 'aws/ses'

class PantryItemsUser < ActiveRecord::Base
  has_many :pantry_items
  has_many :users

  SES = AWS::SES::Base.new(
    :access_key_id => ENV['AWS_KEY'],
    :secret_access_key => ENV['AWS_SECRET'],
    :server => 'email.us-west-2.amazonaws.com'
  )

  def send_expiration_email
    exp_soon = self.where("expiration_date < ?", Time.now + 2)
    puts exp_soon
  end

  def self.expiring_soon(user_id)
    days = User.find(user_id).exp_soon_days
    return  self.where("user_id = ? AND exp_date < ?", user_id, DateTime.now + days)
  end

  def self.consume(pantry_item_id, quant)
    if self.where("pantry_item_id = ?", pantry_item_id)
      p = self.where("pantry_item_id = ?", pantry_item_id).order(exp_date: :asc).first
      if p.quantity > quant
        p.quantity -= quant
        p.save
      elsif p.quantity == quant
        p.delete
      elsif p.quantity < quant
        new_quant = quant - p.quantity
        self.consume(pantry_item_id, new_quant)
      end
    else
      raise "You don't have enough of this item to consume!"
    end
  end


end
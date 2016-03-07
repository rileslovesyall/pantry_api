require 'aws/ses'

class PantryItemsUserLog < ActiveRecord::Base
  belongs_to :pantry_item
  belongs_to :user

  validates_presence_of :action, :quantity

  before_create :act_on_action

  SES = AWS::SES::Base.new(
    :access_key_id => ENV['AWS_KEY'],
    :secret_access_key => ENV['AWS_SECRET'],
    :server => 'email.us-west-2.amazonaws.com'
  )

  def send_expiration_email
    exp_soon = PantryItemUser.where("expiration_date < ?", Time.now + 2)
    puts exp_soon
  end

  def self.expiring_soon(user_id)
    days = User.find(user_id).exp_soon_days
    return  PantryItemUser.where("user_id = ? AND exp_date < ?", user_id, DateTime.now + days)
  end

  private

  def act_on_action
    if self.action == 'add'
        self.pantry_item.quantity += self.quantity
        self.pantry_item.save
    elsif self.action == 'consume'
      if self.pantry_item.quantity >= self.quantity
        self.pantry_item.quantity -= self.quantity
        self.pantry_item.save
      else
        raise "You don't have enough of this item to consume!"
      end
    end
  end

  def set_expiration
    if self.action == 'add' || self.action == 'init'
      self.exp_date = DateTime.now + (self.pantry_item.days_to_exp).to_i
      self.save
    end
  end

end
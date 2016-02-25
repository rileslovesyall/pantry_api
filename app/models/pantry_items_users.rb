class PantryItemUser < ActiveRecord::Base
  belongs_to :pantry_item
  belongs_to :user

  validates_presence_of :action, :quantity

  before_create :act_on_action

  private

  def act_on_action
    if self.action == 'add'
        self.pantry_item.quantity += self.quantity
    elsif self.action == 'consume'
      if self.pantry_item.quantity > self.quantity
        self.pantry_item.quantity -= self.quantity
        self.pantry_item.save
      else
        raise "You don't have enough of this item to consume!"
      end
    end
  end

end
class PantryItemUser < ActiveRecord::Base
  belongs_to :pantry_item
  belongs_to :user

  validates_presence_of :action, :quantity

  after_initialize :act_on_action

  private

  def act_on_action
    if self.action == 'add'
      self.pantry_item.quantity += self.quantity
    elsif self.action == 'consume'
      self.pantry_item.quantity -= self.quantity
    end
  end

end
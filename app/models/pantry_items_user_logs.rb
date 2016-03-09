class PantryItemsUserLog < ActiveRecord::Base
  belongs_to :pantry_item
  belongs_to :user

  validates_presence_of :action, :quantity

  before_create :act_on_action

  private

  def act_on_action
    # binding.pry
    if self.action == 'add'
      # binding.pry
        self.pantry_item.quantity += self.quantity
        self.pantry_item.save
        p = PantryItemsUser.create({
          user_id: self.user.id,
          pantry_item_id: self.pantry_item.id,
          quantity: self.quantity,
          exp_date: DateTime.now + (self.pantry_item.days_to_exp).to_i
        })
        p.save
    elsif self.action == 'consume'
      if self.pantry_item.quantity >= self.quantity
        self.pantry_item.quantity -= self.quantity
        self.pantry_item.save
        PantryItemsUser.consume(self.pantry_item.id, self.quantity)
      else
        raise "You don't have enough of this item to consume!"
      end
    end
  end

end
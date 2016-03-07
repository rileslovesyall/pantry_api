class PantryItemsUser < ActiveRecord::Base
  belongs_to :pantry_item
  belongs_to :user

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
    binding.pry
  end


end
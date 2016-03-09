require 'spec_helper'

RSpec.describe PantryItemsUser, type: :model do

  describe ".expiring_soon(user_id)" do
    it "returns pantry_items belonging to that user" do
      
    end
    it "returns items with expiration dates between now and the number of days set by the user" do
      
    end
  end

  describe ".consume(pantry_item_id, quant)" do
    context "when there are enough of this item to consume" do
      
    end
    context "when there isn't enough of this item to consume" do
      fit "throws an error" do
        p = create(:pantry_item, quantity: 1)
        expect{PantryItemsUser.consume(p.id, 2)}.to raise_error("You don't have enough of this item to consume!")
      end
    end
  end

end
require 'spec_helper'

RSpec.describe PantryItemsUser, type: :model do

  describe ".expiring_soon(user_id)" do
    before do
      u = create(:user)
      u2 = create(:user1, exp_soon_days: 18)
      p1 = create(:pi1, user_id: u.id, days_to_exp: 16)
      p2 = create(:pi2, user_id: u.id, days_to_exp: 2)
      p3 = create(:pi3, user_id: u2.id, days_to_exp: 16)
      p4 = create(:pi4, user_id: u2.id, days_to_exp: 2)
    end
    it "returns pantry_items belonging to that user" do
      expect(PantryItemsUser.expiring_soon(1).length).to eq(1)
    end
    it "returns items with expiration dates between now and the number of days set by the user" do
      expect(PantryItemsUser.expiring_soon(2).length).to eq(2)
    end
  end

  describe ".consume(pantry_item_id, quant)" do
    context "when there are enough of this item to consume" do
      it "subtracts the given quantity from the PIU with closest expiration date" do
        p = create(:pantry_item, quantity: 2)
        piul = create(:piul_add, pantry_item_id: p.id, quantity: 2)
        PantryItemsUser.consume(p.id, 2)
        expect(PantryItemsUser.first.id).to eq(2)
      end
    end
    context "when there isn't enough of this item to consume" do
      it "throws an error" do
        p = create(:pantry_item, quantity: 1)
        expect{PantryItemsUser.consume(p.id, 2)}.to raise_error("You don't have enough of this item to consume!")
      end
    end
  end

end
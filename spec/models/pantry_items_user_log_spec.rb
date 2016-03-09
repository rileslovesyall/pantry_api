require 'spec_helper'

RSpec.describe PantryItemsUserLog, type: :model do

  describe "validates" do
    it "has an action" do
      expect(build(:piul_add)).to be_valid
      expect(build(:piul_add, action: nil)).to be_invalid
    end
    it "has a quantity" do
      expect(build(:piul_consume)).to be_valid
      expect(build(:piul_consume, quantity: nil)).to be_invalid
    end
  end

  describe "#act_on_action" do

    context "when action is add" do
      before do
        @pi = create(:pi1)
        @piu_length = PantryItemsUser.all.length
        @quant = @pi.quantity
        @p = create(:piul_add, pantry_item_id: @pi.id)
      end
      it "adds one to its pantry_item's quantity" do
        expect(@p.pantry_item.quantity).to eq(@quant + 1)
      end
      it "makes a new PantryItemsUser" do
        expect(PantryItemsUser.all.length).to eq(@piu_length + 1)
      end
    end
    context "when action is consume" do
      it "removes that amount from pantry_item quantity if available" do
        pi = create(:pi1)
        quant = pi.quantity
        p = create(:piul_consume, pantry_item_id: pi.id)
        expect(p.pantry_item.quantity).to eq(quant - 1)
      end
      it "returns an error if quantity not available" do
        pi = create(:pi1, quantity: 1)
        expect{create(:piul_consume, pantry_item_id: pi.id, quantity: 2)}.to raise_error("You don't have enough of this item to consume!")
      end
    end
  end

end
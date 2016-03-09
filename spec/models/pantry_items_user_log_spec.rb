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
      it "adds one to its pantry_item's quantity" do
        
      end
      it "makes a new PantryItemsUser" do
        
      end
      it "sets PantryItemUser's exp date properly" do
        
      end
    end
    context "when action is consume" do
      it "removes that amount from pantry_item quantity if available" do
        
      end
      # it "consumes that amount from PantryItemsUser.consume" do
        
      # end
      it "returns an error if quantity not available" do
        
      end
    end
  end

end
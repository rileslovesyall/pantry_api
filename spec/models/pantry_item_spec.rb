require 'spec_helper'

RSpec.describe PantryItem, type: :model do

  describe ".validates" do
    it "must have a name" do
      expect(build(:pantry_item)).to be_valid
      expect(build(:pantry_item, name: nil)).to be_invalid
    end
    it "must have a quantity" do
      expect(build(:pantry_item)).to be_valid
      expect(build(:pantry_item, quantity: nil)).to be_invalid
    end
    it "must have a days_to_exp" do
      expect(build(:pantry_item)).to be_valid
      expect(build(:pantry_item, days_to_exp: nil)).to be_invalid
    end
    it "must have a portion" do
      expect(build(:pantry_item)).to be_valid
      expect(build(:pantry_item, portion: nil)).to be_invalid
    end
  end

  describe ".public" do
    it "returns all pantryitems with show_public: true and quantity > 0" do
      p1 = create(:pi1)
      p2 = create(:pi2)
      p3 = create(:pi3)
      p4 = create(:pi4, quantity: 0)
      expect(PantryItem.public.length).to eq(2)
    end
  end

end


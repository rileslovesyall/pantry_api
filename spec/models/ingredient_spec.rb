require 'spec_helper'

RSpec.describe Ingredient, type: :model do

  describe "validates" do
    it "has a unique name" do
      i = create(:ingredient)
      expect(create(:ingredient)).to be_invalid
      expect(build(:ingredient, name: nil)).to be_invalid
      expect(build(:ingredient, name: "Something Else")).to be_valid
    end
  end

  describe ".find_or_create(ing_hash)" do
    before :each do
      i = create(:ingredient)
    end
    it "returns Ingredient with name if it exists" do
      expect(Ingredient.find_or_create({name: "Salt"}).id).to eq(1)
    end
    it "create a new Ingredient if one with name doesn't yet exist" do
      expect(Ingredient.find_or_create({name: "Not Salt"}).id).to eq(2)
    end
    it "is case insensitive" do
      expect(Ingredient.find_or_create({name: "salt"}).id).to eq(1)
    end
  end

end
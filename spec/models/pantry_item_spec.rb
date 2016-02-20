require 'spec_helper'

RSpec.describe PantryItem, type: :model do

  describe ".validates" do
    it "must have a name" do
      expect(build(:pantry_item)).to be_valid
      expect(build(:pantry_item, name: nil)).to be_invalid
    end
  end

end
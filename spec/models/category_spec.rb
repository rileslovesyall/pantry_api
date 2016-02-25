require 'spec_helper'

RSpec.describe Category, type: :model do

  describe ".validates" do
    it "must have a unique name" do
      c = create(:category)
      expect(build(:category)).to be_invalid
      expect(build(:category, name: "Something Else")).to be_valid
    end
  end

end
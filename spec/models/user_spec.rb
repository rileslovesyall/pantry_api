require 'spec_helper'

RSpec.describe User, type: :model do

  describe ".validates" do
    it "must have an email" do
      expect(build(:user1)).to be_valid
      expect(build(:user1, email: nil)).to be_invalid
    end
    it "must have unique email" do
      user = create(:user1)
      expect(build(:user1)).to be_invalid
    end
  end

end
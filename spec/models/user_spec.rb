require 'spec_helper'

RSpec.describe User, type: :model do

  describe ".validates" do
    it "must have an email" do
      expect(build(:user)).to be_valid
      expect(build(:user, email: nil)).to be_invalid
    end
    it "must have unique email" do
      user = create(:user)
      expect(build(:user)).to be_invalid
    end
  end

end
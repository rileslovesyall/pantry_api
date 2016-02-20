require 'spec_helper'

RSpec.describe User, type: :model do

  describe ".validates" do
    it "must have an email" do
      expect(build(:user)).to be_valid
      expect(build(:user, email: nil)).to be_invalid
    end
  end

end
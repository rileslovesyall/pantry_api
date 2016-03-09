require 'spec_helper'
require './app/models/user.rb'

RSpec.describe User, type: :model do

  let (:make_user) {
    @u = create(:full_pantry_user)
    p1 = create(:pi1, user_id: @u.id)
    p2 = create(:pi2, user_id: @u.id)
    p3 = create(:pi3, user_id: @u.id)
  }

  describe ".validates" do
    it "must have a unique email" do
      expect(create(:user1)).to be_valid
      expect(build(:user1, email: nil)).to be_invalid
      expect(build(:user1)).to be_invalid
    end
    it "must have properly formatted email" do
      expect(build(:user1, email: 123)).to be_invalid
    end
  end

  describe "#get_token" do
    it 'sets a unique api_token for a user' do
      u1 = create(:user1)
      u2 = create(:user2)
      expect(u1.api_token).not_to eq(nil)
      expect(u1.api_token).not_to eq(u2.api_token)

      token = u2.api_token
      u2.get_token
      expect(token).not_to eq(u2.api_token)
    end
  end

  describe '#personal_pantry' do
    it "returns all items in a user's pantry" do
      make_user
      expect(@u.personal_pantry.length).to eq(3)
    end
  end

  describe '#public_pantry' do
    it "returns user's items where show_public is true" do
      make_user
      expect(@u.public_pantry.length).to eq(2)
    end
  end

  describe '#private_pantry' do
    it "returns user's items where show_public is false" do
      make_user
      expect(@u.private_pantry.length).to eq(1)
    end
  end

  describe '.send_expiration_emails' do
    
  end

end
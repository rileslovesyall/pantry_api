require 'spec_helper'
require './app/models/user.rb'

RSpec.describe User, type: :model do

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
    
  end

  describe '#public_pantry' do
    
  end

  describe '#private_pantry' do
    
  end

  describe '.send_expiration_emails' do
    
  end

end
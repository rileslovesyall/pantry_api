require 'spec_helper'
require './app/models/user.rb'

RSpec.describe User, type: :model do

  describe ".validates" do
    xit "must have a unique email" do
      expect(build(:user1)).to be_valid
      expect(build(:user1, email: nil)).to be_invalid
      expect(build(:user1)).to be_invalid
    end
    it "must have properly formatted email" do
      expect(build(:user1, email: 123)).to be_invalid
    end
  end

  describe '#pantry' do
    
  end

  describe '#public_pantry' do
    
  end

  describe '#private_pantry' do
    
  end

  describe 'consumed_pantry' do
    
  end

end
require 'spec_helper'

RSpec.describe Pantry::Controller::Users, type: :controller do
  before do
    @base = '/api/v1/users'
  end

  describe 'GET /:id' do
    xit "is successful" do
      get "/1"
      expect(last_response.status).to eq(200)
    end
  end

end
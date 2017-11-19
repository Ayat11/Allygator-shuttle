require 'rails_helper'

RSpec.describe Api::VehiclesController, type: :controller do
  describe "POST #register" do
    it "returns success" do
      post :register, params: {id: 'hey4-s23dj'}
      expect(response.status).to eq(204)
    end
  end

  describe "POST #update_location" do
    it "returns success" do
      FactoryBot.create(:vehicle, identity: 'hjk23-ywu')
      post :update_location, params: {id: 'hjk23-ywu', "lat": 10.0, "lng": 20.0, "at": "2017-09-01T12:00:00Z" }
      expect(response.status).to eq(204)
    end
  end

  describe "DELETE #de_register" do
    it "returns success" do
      FactoryBot.create(:vehicle, identity: 'hjk23-23ere')
      delete :de_register, params: {id: 'hjk23-23ere'}
      expect(response.status).to eq(204)
    end
  end
end
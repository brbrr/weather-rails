require 'rails_helper'

RSpec.describe DataController, type: :controller do

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #hourly" do
    it "returns http success" do
      get :hourly
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #last24h" do
    it "returns http success" do
      get :last24h
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #last24h/hourly" do
    it "returns http success" do
      get :last24h/hourly
      expect(response).to have_http_status(:success)
    end
  end

end

require "rails_helper"

RSpec.describe TestReportsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/test_reports").to route_to("test_reports#index")
    end

    it "routes to #new" do
      expect(:get => "/test_reports/new").to route_to("test_reports#new")
    end

    it "routes to #show" do
      expect(:get => "/test_reports/1").to route_to("test_reports#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/test_reports/1/edit").to route_to("test_reports#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/test_reports").to route_to("test_reports#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/test_reports/1").to route_to("test_reports#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/test_reports/1").to route_to("test_reports#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/test_reports/1").to route_to("test_reports#destroy", :id => "1")
    end

  end
end

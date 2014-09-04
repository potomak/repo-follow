require "rails_helper"

RSpec.describe SessionsController, :type => :routing do
  describe "routing" do

    it "routes to #new" do
      expect(:get => "/sign_in/test").to route_to("sessions#new", :provider => "test")
    end

    it "routes to #create" do
      expect(:get => "/auth/test/callback").to route_to("sessions#create", :provider => "test")
      expect(:post => "/auth/test/callback").to route_to("sessions#create", :provider => "test")
    end

    it "routes to #destroy" do
      expect(:delete => "/sign_out").to route_to("sessions#destroy")
    end

    it "routes to #failure" do
      expect(:get => "/auth/failure").to route_to("sessions#failure")
    end

  end
end

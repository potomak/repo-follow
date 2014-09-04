require "rails_helper"

RSpec.describe CommitsController, :type => :routing do
  describe "routing" do

    it "routes to #show" do
      expect(:get => "/commits/1").to route_to("commits#show", :id => "1")
    end

  end
end

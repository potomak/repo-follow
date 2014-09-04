require "rails_helper"

RSpec.describe RepositoriesController, :type => :routing do
  describe "routing" do

    it "routes to #show" do
      expect(:get => "/repositories/user/repo").to route_to("repositories#show", :id => "user/repo")
      expect(:get => "/repositories/user_1/Re-po").to route_to("repositories#show", :id => "user_1/Re-po")
    end

  end
end

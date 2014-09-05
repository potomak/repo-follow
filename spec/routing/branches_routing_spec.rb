require "rails_helper"

RSpec.describe BranchesController, :type => :routing do
  describe "routing" do

    it "routes to #follow" do
      expect(:post => "/branches/test/repo/master/follow").to route_to("branches#follow", :repository_id => "test/repo", :id => "master")
      expect(:post => "/branches/test/repo/feature/test/follow").to route_to("branches#follow", :repository_id => "test/repo", :id => "feature/test")
      expect(:post => "/branches/test/repo/feature/with/slashes/follow").to route_to("branches#follow", :repository_id => "test/repo", :id => "feature/with/slashes")
    end

    it "routes to #unfollow" do
      expect(:post => "/branches/test/repo/feature/test/unfollow").to route_to("branches#unfollow", :repository_id => "test/repo", :id => "feature/test")
    end

  end
end

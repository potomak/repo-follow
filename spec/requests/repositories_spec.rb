require 'rails_helper'

RSpec.describe "Repositories", :type => :request do
  describe "GET /repositories" do
    it "works! (now write some real specs)" do
      pending
      get repositories_path
      expect(response.status).to be(200)
    end
  end
end

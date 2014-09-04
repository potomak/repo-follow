require 'rails_helper'

RSpec.describe RepositoriesController, :type => :controller do

  let(:valid_attributes) { { full_name: 'test/repo' } }
  let(:valid_session) { {} }

  describe "GET show" do
    it "assigns the requested repository as @repository" do
      repository = Repository.create! valid_attributes
      get :show, {:id => repository.to_param}, valid_session
      expect(assigns(:repository)).to eq(repository)
    end

    it "creates the requested repository" do
      expect {
        get :show, {:id => 'test/repo'}, valid_session
      }.to change { Repository.count }.by(1)
    end
  end

end

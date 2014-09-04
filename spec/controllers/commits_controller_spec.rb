require 'rails_helper'

RSpec.describe CommitsController, :type => :controller do

  let(:valid_attributes) { {sha: '123'} }
  let(:valid_session) { {} }

  describe "GET show" do
    it "assigns the requested commit as @commit" do
      commit = Commit.create! valid_attributes
      get :show, {:id => commit.to_param}, valid_session
      expect(assigns(:commit)).to eq(commit)
    end

    it "creates the requested commit" do
      expect {
        get :show, {:id => '123'}, valid_session
      }.to change { Commit.count }.by(1)
    end
  end

end

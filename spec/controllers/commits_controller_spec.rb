require 'rails_helper'

RSpec.describe CommitsController, :type => :controller do

  let(:current_user) { User.create }
  let(:valid_attributes) { {sha: '123'} }
  let(:valid_session) { { user_id: current_user.id } }

  describe "GET show" do
    it 'redirects to /' do
      commit = Commit.create! valid_attributes
      get :show, {:id => commit.to_param}
      expect(response).to redirect_to(root_url)
    end

    context 'with a valid session' do
      it "assigns the requested commit as @commit" do
        commit = Commit.create! valid_attributes
        get :show, {:id => commit.to_param}, valid_session
        expect(assigns(:commit)).to eq(commit)
      end
    end
  end

end

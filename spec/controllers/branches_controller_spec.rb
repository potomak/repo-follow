require 'rails_helper'

RSpec.describe BranchesController, :type => :controller do

  let(:current_user) { User.create }
  let(:repository) { Repository.create(full_name: 'test/repo') }
  let(:valid_attributes) { { name: 'feature/test' } }
  let(:valid_session) { { user_id: current_user.id } }

  describe "POST follow" do
    it 'redirects to /' do
      branch = repository.branches.create! valid_attributes
      post :follow, {:repository_id => repository.to_param, :id => branch.to_param}
      expect(response).to redirect_to(root_url)
    end

    context 'with a valid session' do
      before { allow_any_instance_of(Branch).to receive(:fetch_and_update_or_create_commits) }

      it "assigns the requested branch as @branch" do
        branch = repository.branches.create! valid_attributes
        post :follow, {:repository_id => repository.to_param, :id => branch.to_param}, valid_session
        expect(assigns(:branch)).to eq(branch)
      end

      it "adds current_user to branch's followers" do
        branch = repository.branches.create! valid_attributes
        expect {
          post :follow, {:repository_id => repository.to_param, :id => branch.to_param}, valid_session
        }.to change { branch.users.count }.by(1)
      end
    end
  end

  describe "POST unfollow" do
    it 'redirects to /' do
      branch = repository.branches.create! valid_attributes
      post :unfollow, {:repository_id => repository.to_param, :id => branch.to_param}
      expect(response).to redirect_to(root_url)
    end

    context 'with a valid session' do
      it "assigns the requested branch as @branch" do
        branch = repository.branches.create! valid_attributes
        post :unfollow, {:repository_id => repository.to_param, :id => branch.to_param}, valid_session
        expect(assigns(:branch)).to eq(branch)
      end

      it "adds current_user to branch's followers" do
        branch = repository.branches.create! valid_attributes
        branch.users << current_user
        expect {
          post :unfollow, {:repository_id => repository.to_param, :id => branch.to_param}, valid_session
        }.to change { branch.users.count }.by(-1)
      end
    end
  end

end

require 'rails_helper'

RSpec.describe RepositoriesController, :type => :controller do

  let(:current_user) { User.create }
  let(:valid_attributes) { { full_name: 'test/repo' } }
  let(:valid_session) { { user_id: current_user.id } }

  describe "GET show" do
    it 'redirects to /' do
      repository = Repository.create! valid_attributes
      get :show, {:id => repository.to_param}
      expect(response).to redirect_to(root_url)
    end

    context 'with a valid session' do
      let(:octokit_result) { double(full_name: 'test/repo', owner: double(login: 'test', avatar_url: 'image_url')) }
      before { allow_any_instance_of(Octokit::Client).to receive(:repository).and_return(octokit_result) }

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

end

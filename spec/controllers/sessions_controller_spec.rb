require 'rails_helper'

RSpec.describe SessionsController, :type => :controller do

  describe "GET new" do
    it "redirects to /auth/test" do
      get :new, { provider: 'test' }
      expect(response).to redirect_to('/auth/test')
    end
  end

  describe "GET create" do
    let(:auth_hash) { OmniAuth::AuthHash.new(uid: 'test') }

    before { request.env['omniauth.auth'] = auth_hash }

    it "assigns a user to @current_user" do
      user = User.find_or_create_from_auth_hash(auth_hash)
      get :create, { provider: 'test' }
      expect(assigns(:current_user)).to eq(user)
    end

    it "redirects to /" do
      get :create, { provider: 'test' }
      expect(response).to redirect_to(root_url)
    end
  end

  describe "GET destroy" do
    let(:user) { User.create }
    before { session[:user_id] = user.id }

    it "redirects to /" do
      get :destroy
      expect(response).to redirect_to(root_url)
    end

    it "resets session" do
      expect {
        get :destroy
      }.to change { session[:user_id] }.to(nil)
    end
  end

  describe "GET failure" do
    it "prints an error message" do
      get :failure
      expect(flash[:alert]).to match(/Authentication error/)
    end

    it "redirects to /" do
      get :failure
      expect(response).to redirect_to(root_url)
    end
  end

end

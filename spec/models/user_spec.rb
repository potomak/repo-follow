require 'rails_helper'

RSpec.describe User, :type => :model do
  describe '::find_or_create_from_auth_hash' do
    let(:auth_hash) { OmniAuth::AuthHash.new(uid: 'test') }

    context 'with user' do
      let!(:user) { User.create(uid: 'test') }

      it 'returns user' do
        expect(User.find_or_create_from_auth_hash(auth_hash)).to eq(user)
      end
    end

    context 'without user' do
      it 'creates new user' do
        expect {
          User.find_or_create_from_auth_hash(auth_hash)
        }.to change { User.count }.by(1)
      end
    end
  end

  describe '#github_client' do
    let(:user) { User.create(token: 'test') }

    it 'returns a Octokit::Client' do
      expect(user.github_client).to be_a(Octokit::Client)
    end

    it 'has user\'s token' do
      expect(user.github_client.access_token).to eq(user.token)
    end
  end

  describe '#follows' do
    let(:user) { User.create(token: 'test') }
    let(:branch) { Branch.create }

    context 'with association between user and branch' do
      before { user.branches << branch }

      it 'returns true' do
        expect(user.follows(branch)).to be true
      end
    end

    context 'without association' do
      it 'returns false' do
        expect(user.follows(branch)).to_not be true
      end
    end
  end
end

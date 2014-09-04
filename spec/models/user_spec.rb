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
end

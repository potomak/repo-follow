require 'rails_helper'

RSpec.describe Commit, :type => :model do
  describe '::find_or_create_by_sha' do
    context 'with commit' do
      let!(:commit) { Commit.create(sha: '123') }

      it 'returns commit' do
        expect(Commit.find_or_create_by_sha('123')).to eq(commit)
      end
    end

    context 'without commit' do
      it 'creates a new commit' do
        expect {
          Commit.find_or_create_by_sha('123')
        }.to change { Commit.count }.by(1)
      end
    end
  end
end

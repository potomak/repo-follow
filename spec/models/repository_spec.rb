require 'rails_helper'

RSpec.describe Repository, :type => :model do
  describe '::find_and_update_or_create_by_full_name' do
    let(:octokit_result) { double(full_name: 'test/repo', owner: double(login: 'test', avatar_url: 'image_url')) }
    let(:github_client) { Octokit::Client.new }

    context 'with repository' do
      let!(:repository) { Repository.create(full_name: 'test/repo') }

      it 'returns repository' do
        allow(Repository).to receive(:fetch_by_full_name).and_return(repository)
        expect(Repository.find_and_update_or_create_by_full_name(github_client, 'test/repo')).to eq(repository)
      end

      context 'when needs refresh' do
        before { allow_any_instance_of(Repository).to receive(:needs_refresh?).and_return(true) }

        it 'fetches the repository from GitHub and updates repository' do
          expect(Repository).to receive(:fetch_by_full_name).with(github_client, 'test/repo').and_return(repository)
          expect_any_instance_of(Repository).to receive(:update_attributes)
          Repository.find_and_update_or_create_by_full_name(github_client, 'test/repo')
        end
      end
    end

    context 'without repository' do
      let(:repository) { Repository.new(full_name: 'test/repo') }

      it 'fetches the repository from GitHub' do
        expect(Repository).to receive(:fetch_by_full_name).with(github_client, 'test/repo').and_return(repository)
        Repository.find_and_update_or_create_by_full_name(github_client, 'test/repo')
      end

      it 'creates a new repository' do
        allow(Repository).to receive(:fetch_by_full_name).and_return(repository)
        expect {
          Repository.find_and_update_or_create_by_full_name(github_client, 'test/repo')
        }.to change { Repository.count }.by(1)
      end
    end
  end

  describe '::fetch_by_full_name' do
    let(:octokit_result) { double(full_name: 'test/repo', owner: double(login: 'test', avatar_url: 'image_url')) }
    let(:github_client) { Octokit::Client.new }

    it 'returns a new Repository' do
      allow(github_client).to receive(:repository).and_return(octokit_result)
      expect(Repository.fetch_by_full_name(github_client, 'test/repo')).to be_a(Repository)
    end

    it 'makes a request to GitHub\'s repositories API' do
      expect(github_client).to receive(:repository).with('test/repo').and_return(octokit_result)
      Repository.fetch_by_full_name(github_client, 'test/repo')
    end
  end

  describe '#needs_refresh?' do
    let(:repository) { Repository.create }

    context 'with last update older than Time.now - Repository::REFRESH_AFTER' do
      before { repository.update(updated_at: repository.updated_at - Repository::REFRESH_AFTER) }

      it 'returns true' do
        expect(repository.needs_refresh?).to be true
      end
    end

    context 'with last update newer than Time.now - Repository::REFRESH_AFTER' do
      it 'returns false' do
        expect(repository.needs_refresh?).to_not be true
      end
    end
  end
end

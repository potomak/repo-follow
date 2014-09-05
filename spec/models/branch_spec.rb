require 'rails_helper'

RSpec.describe Branch, :type => :model do
  describe '#fetch_and_update_or_create_commits' do
    let(:repository) { Repository.create(full_name: 'test/repo') }
    let(:branch) { Branch.create(name: 'master', repository: repository) }
    let(:remote_commits) { [double(sha: '123', commit: double(author: double(name: 'John Doe'), message: 'commit message'), author: double(avatar_url: 'image_url'))] }
    let(:github_client) { Octokit::Client.new }

    it 'makes a request to GitHub\'s commits API' do
      expect(github_client).to receive(:commits).with('test/repo', 'master').and_return(remote_commits)
      branch.fetch_and_update_or_create_commits(github_client)
    end

    context 'with commits' do
      let!(:commit) { branch.commits.create(sha: '123', message: 'another message') }

      it 'updates commits' do
        allow(github_client).to receive(:commits).and_return(remote_commits)
        expect {
          branch.fetch_and_update_or_create_commits(github_client)
        }.to change { commit.reload.message }.to('commit message')
      end
    end

    context 'without commits' do
      it 'creates new commits' do
        allow(github_client).to receive(:commits).and_return(remote_commits)
        expect {
          branch.fetch_and_update_or_create_commits(github_client)
        }.to change { branch.commits.count }.by(1)
      end
    end
  end
end

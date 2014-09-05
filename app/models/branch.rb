class Branch < ActiveRecord::Base
  has_and_belongs_to_many :users
  has_and_belongs_to_many :commits
  belongs_to :repository

  def to_param
    self.name
  end

  def fetch_and_update_or_create_commits(github_client)
    remote_commits = github_client.commits(self.repository.full_name, self.name)

    remote_commits.each do |remote_commit|
      commit = Commit.find_or_initialize_by(sha: remote_commit.sha)
      commit.assign_attributes(
        message: remote_commit.commit.message,
        author: remote_commit.commit.author.name,
        author_image: remote_commit.author.avatar_url,
        repository: self.repository
      )
      commit.branches << self unless self.commits.exists?(commit)
      commit.save
    end
  end
end

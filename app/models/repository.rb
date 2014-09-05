class Repository < ActiveRecord::Base
  REFRESH_AFTER = 1.day

  has_many :commits
  has_many :branches

  def self.find_and_update_or_create_by_full_name(github_client, full_name)
    repository = self.find_by_full_name(full_name)

    if repository
      if repository.needs_refresh?
        remote_repository = self.fetch_by_full_name(github_client, full_name)
        repository.update_attributes(remote_repository.attributes)
        remote_branches = repository.fetch_branches(github_client)
        remote_branches.map(&:save)
      end
      return repository
    end

    repository = self.fetch_by_full_name(github_client, full_name)
    repository.save
    remote_branches = repository.fetch_branches(github_client)
    remote_branches.map(&:save)
    repository
  end

  def self.fetch_by_full_name(github_client, full_name)
    remote_repository = github_client.repository(full_name)

    self.new(
      full_name: remote_repository.full_name,
      owner: remote_repository.owner.login,
      owner_image: remote_repository.owner.avatar_url
    )
  end

  def fetch_branches(github_client)
    remote_branches = github_client.branches(self.full_name)

    remote_branches.map do |remote_branch|
      branch = Branch.find_or_initialize_by(name: remote_branch.name)
      branch.assign_attributes(sha: remote_branch.sha, repository: self)
      branch
    end
  end

  def to_param
    self.full_name
  end

  def needs_refresh?
    self.updated_at < Time.now - self.class::REFRESH_AFTER
  end
end

class Repository < ActiveRecord::Base
  REFRESH_AFTER = 1.day

  has_and_belongs_to_many :users
  has_many :commits

  def self.find_and_update_or_create_by_full_name(github_client, full_name)
    repository = self.find_by_full_name(full_name)

    if repository
      if repository.needs_refresh?
        remote_repository = self.fetch_by_full_name(github_client, full_name)
        repository.update_attributes(remote_repository.attributes)
      end
      return repository
    end

    remote_repository = self.fetch_by_full_name(github_client, full_name)
    remote_repository.save
    remote_repository
  end

  def self.fetch_by_full_name(github_client, full_name)
    github_repository = github_client.repository(full_name)

    self.new(
      full_name: github_repository.full_name,
      owner: github_repository.owner.login,
      owner_image: github_repository.owner.avatar_url
    )
  end

  def to_param
    self.full_name
  end

  def needs_refresh?
    self.updated_at < Time.now - self.class::REFRESH_AFTER
  end
end

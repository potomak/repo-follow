class Commit < ActiveRecord::Base
  belongs_to :repository

  def to_param
    self.sha
  end

  def self.find_or_create_by_sha(sha)
    commit = self.find_by_sha(sha)
    return commit if commit

    self.create(sha: sha)
  end

  def title
    self.message.split("\n").first
  end
end

class Repository < ActiveRecord::Base
  has_and_belongs_to_many :users
  has_many :commits

  def to_param
    self.full_name
  end

  def self.find_or_create_by_full_name(full_name)
    repository = self.find_by_full_name(full_name)
    return repository if repository

    self.create(full_name: full_name)
  end
end

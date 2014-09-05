class Branch < ActiveRecord::Base
  has_and_belongs_to_many :users
  has_and_belongs_to_many :commits
  belongs_to :repository

  def to_param
    self.name
  end
end

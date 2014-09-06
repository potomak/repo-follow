class Commit < ActiveRecord::Base
  belongs_to :repository
  has_and_belongs_to_many :branches

  def to_param
    self.sha
  end

  def title
    self.message.split("\n").first
  end
end

class Commit < ActiveRecord::Base
  belongs_to :repository

  def to_param
    self.sha
  end
end

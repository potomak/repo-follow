class Repository < ActiveRecord::Base
  has_and_belongs_to_many :users
  has_many :commits

  def to_param
    self.full_name
  end
end

class User < ActiveRecord::Base
  has_and_belongs_to_many :repositories

  def self.find_or_create_from_auth_hash(auth_hash)
    user = self.find_by_uid(auth_hash[:uid])
    return user if user

    self.create(
      uid: auth_hash.uid,
      name: auth_hash.info.try(:name),
      nickname: auth_hash.info.try(:nickname),
      image: auth_hash.info.try(:image),
      token: auth_hash.credentials.try(:token)
    )
  end
end

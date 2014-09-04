class CreateFollowingJoinTable < ActiveRecord::Migration
  def change
    create_join_table :repositories, :users do |t|
      # t.index [:repository_id, :user_id]
      t.index [:user_id, :repository_id], unique: true
    end
  end
end

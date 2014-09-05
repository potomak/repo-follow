class CreateFollowingJoinTable < ActiveRecord::Migration
  def change
    create_join_table :branches, :users do |t|
      # t.index [:branch_id, :user_id]
      t.index [:user_id, :branch_id], unique: true
    end
  end
end

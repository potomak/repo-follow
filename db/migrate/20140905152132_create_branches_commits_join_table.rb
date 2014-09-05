class CreateBranchesCommitsJoinTable < ActiveRecord::Migration
  def change
    create_join_table :branches, :commits do |t|
      # t.index [:branch_id, :commit_id]
      t.index [:commit_id, :branch_id], unique: true
    end
  end
end

class CreateBranches < ActiveRecord::Migration
  def change
    create_table :branches do |t|
      t.string :name
      t.string :sha
      t.references :repository, index: true

      t.timestamps
    end
  end
end

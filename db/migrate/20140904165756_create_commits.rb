class CreateCommits < ActiveRecord::Migration
  def change
    create_table :commits do |t|
      t.string :sha
      t.text :message
      t.string :author
      t.string :author_image
      t.string :committer
      t.string :committer_image
      t.references :repository, index: true

      t.timestamps
    end
  end
end

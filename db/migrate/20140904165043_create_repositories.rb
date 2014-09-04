class CreateRepositories < ActiveRecord::Migration
  def change
    create_table :repositories do |t|
      t.string :full_name

      t.timestamps
    end
    add_index :repositories, :full_name, unique: true
  end
end

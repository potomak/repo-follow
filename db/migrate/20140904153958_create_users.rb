class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :uid
      t.string :name
      t.string :nickname
      t.string :image
      t.string :token

      t.timestamps
    end
    add_index :users, :uid, unique: true
  end
end

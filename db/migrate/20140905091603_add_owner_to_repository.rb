class AddOwnerToRepository < ActiveRecord::Migration
  def change
    add_column :repositories, :owner, :string
    add_column :repositories, :owner_image, :string
  end
end

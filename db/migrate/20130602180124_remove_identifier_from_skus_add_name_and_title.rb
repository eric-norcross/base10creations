class RemoveIdentifierFromSkusAddNameAndTitle < ActiveRecord::Migration
  def change
    remove_column :skus, :identifier
    add_column :skus, :name, :string
    add_column :skus, :title, :string
  end
end

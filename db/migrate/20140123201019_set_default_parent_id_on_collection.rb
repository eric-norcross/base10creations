class SetDefaultParentIdOnCollection < ActiveRecord::Migration
  def change
    change_column :collections, :parent_id, :integer, :default => 0

    Collection.update_all ["parent_id = ?", 0]
  end
end

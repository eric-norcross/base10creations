class DropItemType < ActiveRecord::Migration[5.1]
  def change
    remove_column :items, :item_type_id
    drop_table :item_types
  end
end

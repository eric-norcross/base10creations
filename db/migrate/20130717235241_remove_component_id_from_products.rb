class RemoveComponentIdFromProducts < ActiveRecord::Migration
  def up
    remove_column :products, :component_id
  end

  def down
    add_column :products, :component_id, :string
  end
end

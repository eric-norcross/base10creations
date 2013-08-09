class RemoveSubcomponentIdFromProducts < ActiveRecord::Migration
  def up
    remove_column :products, :subcomponent_id
  end

  def down
    add_column :products, :subcomponent_id, :string
  end
end

class RemoveComponentIdFromCompilations < ActiveRecord::Migration
  def up
    remove_column :compilations, :component_id
  end

  def down
    add_column :compilations, :component_id, :string
  end
end

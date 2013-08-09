class RemoveSubcomponentIdFromCompilations < ActiveRecord::Migration
  def up
    remove_column :compilations, :subcomponent_id
  end

  def down
    add_column :compilations, :subcomponent_id, :integer
  end
end

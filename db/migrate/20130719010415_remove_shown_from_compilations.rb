class RemoveShownFromCompilations < ActiveRecord::Migration
  def up
    remove_column :compilations, :shown
  end

  def down
    add_column :compilations, :shown, :string
  end
end

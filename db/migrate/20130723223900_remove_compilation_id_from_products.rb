class RemoveCompilationIdFromProducts < ActiveRecord::Migration
  def up
    remove_column :products, :compilation_id
  end

  def down
    add_column :products, :compilation_id, :string
  end
end

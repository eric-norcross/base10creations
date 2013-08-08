class RemoveCompilationIdFromProductComponents < ActiveRecord::Migration
  def up
    remove_column :product_components, :compilation_id
  end

  def down
    add_column :product_components, :compilation_id, :string
  end
end

class ChangeTableName < ActiveRecord::Migration
  def change
    rename_table :product_components, :product_compilation_components
    add_column :product_compilation_components, :compilation_id, :integer
  end
end

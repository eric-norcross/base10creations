class ChangeProductCompilationComponentsTableName < ActiveRecord::Migration
  def change
    rename_table :product_compilation_components, :product_components
  end
end

class RemoveCompilationIdFromSkus < ActiveRecord::Migration
  def up
    remove_column :skus, :compilation_id
  end

  def down
    add_column :skus, :compilation_id, :string
  end
end

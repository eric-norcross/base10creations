class AddCompilationIdToSkus < ActiveRecord::Migration
  def change
    add_column :skus, :compilation_id, :integer
  end
end

class CreateCompilationSkus < ActiveRecord::Migration
  def change
    create_table :compilation_skus do |t|
      t.integer :compilation_id
      t.integer :sku_id
      
      t.timestamps
    end

    add_index :compilation_skus, :compilation_id
    add_index :compilation_skus, :sku_id
    add_index :compilation_skus, [:compilation_id, :sku_id], unique: true
  end
end

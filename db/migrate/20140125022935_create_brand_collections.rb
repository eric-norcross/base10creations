class CreateBrandCollections < ActiveRecord::Migration
  def change
    create_table :brand_collections do |t|
      t.integer :brand_id
      t.integer :collection_id

      t.timestamps
    end

    add_index :brand_collections, :brand_id
    add_index :brand_collections, :collection_id
    add_index :brand_collections, [:brand_id, :collection_id], unique: true
  end
end

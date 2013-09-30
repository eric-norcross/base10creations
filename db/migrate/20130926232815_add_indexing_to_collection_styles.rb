class AddIndexingToCollectionStyles < ActiveRecord::Migration
  def change
    add_index :collection_styles, :collection_id
    add_index :collection_styles, :style_id
    add_index :collection_styles, [:collection_id, :style_id], unique: true

    add_index :product_components, :product_id
    add_index :product_components, :component_id
    add_index :product_components, [:product_id, :component_id], unique: true
  end
end

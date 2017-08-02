class AddAssetToImage < ActiveRecord::Migration[5.1]
  def change
    add_column :images, :asset, :string, null: false
  end
end

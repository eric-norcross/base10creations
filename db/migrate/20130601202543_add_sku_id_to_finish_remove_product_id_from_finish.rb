class AddSkuIdToFinishRemoveProductIdFromFinish < ActiveRecord::Migration
  def change
    remove_column :finishes, :product_id
    add_column :finishes, :sku_id, :integer
  end
end

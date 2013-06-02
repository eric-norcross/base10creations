class RemoveSkuIdFromFinishesAddFinishIdToSkus < ActiveRecord::Migration
  def change
    remove_column :finishes, :sku_id
    add_column :skus, :finish_id, :integer
  end
end

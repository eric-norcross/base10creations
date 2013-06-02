class RemoveFinishIdFromSkus < ActiveRecord::Migration
  def change
    remove_column :skus, :finish_id
  end
end

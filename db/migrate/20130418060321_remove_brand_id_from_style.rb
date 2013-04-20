class RemoveBrandIdFromStyle < ActiveRecord::Migration
  def change
    remove_column :styles, :brand_id
  end
end

class AddProductIdAndComponentIdToProductComponents < ActiveRecord::Migration
  def change
    add_column :product_components, :product_id, :integer
    add_column :product_components, :component_id, :integer
  end
end

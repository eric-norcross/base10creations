class AddWidthHeightDepthProductIdToDimensions < ActiveRecord::Migration
  def change
    add_column :dimensions, :width, :float
    add_column :dimensions, :height, :float
    add_column :dimensions, :depth, :float
    add_column :dimensions, :product_id, :integer
  end
end

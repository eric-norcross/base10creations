class AddStyleAndVideoToProduct < ActiveRecord::Migration
  def change
    add_column :products, :style, :text
    add_column :products, :video, :string
  end
end

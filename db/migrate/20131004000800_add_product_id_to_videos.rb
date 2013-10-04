class AddProductIdToVideos < ActiveRecord::Migration
  def change
    add_column :videos, :product_id, :integer
  end
end

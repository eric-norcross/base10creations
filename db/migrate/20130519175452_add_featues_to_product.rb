class AddFeatuesToProduct < ActiveRecord::Migration
  def change
    add_column :products, :features, :text
  end
end

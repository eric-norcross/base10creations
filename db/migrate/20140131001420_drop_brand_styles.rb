class DropBrandStyles < ActiveRecord::Migration
  def change 
    drop_table :brand_styles
  end
end

class RemoveBrandIdFromStyles < ActiveRecord::Migration
  def up
    remove_column :styles, :brand_id
  end

  def down
    add_column :styles, :brand_id, :string
  end
end

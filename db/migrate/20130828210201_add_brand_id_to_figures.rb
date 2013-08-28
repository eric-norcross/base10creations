class AddBrandIdToFigures < ActiveRecord::Migration
  def change
    add_column :figures, :brand_id, :integer
  end
end

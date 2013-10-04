class FigureCleanUp < ActiveRecord::Migration
  def change
    add_index :figures, [:figurable_id, :figurable_type]
    remove_column :figures, :page_id
    remove_column :figures, :carousel_id
    remove_column :figures, :brand_id
  end
end

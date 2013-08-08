class AddIncludeFinishNameToProductsAndCompilations < ActiveRecord::Migration
  def change
    add_column :products, :include_finish_name, :boolean
    add_column :compilations, :include_finish_name, :boolean
  end
end

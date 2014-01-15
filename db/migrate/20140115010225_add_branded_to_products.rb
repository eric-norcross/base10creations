class AddBrandedToProducts < ActiveRecord::Migration
  def change
    add_column :products, :branded, :boolean, :default => true
  end
end

class AddActiveAndShownToProducts < ActiveRecord::Migration
  def change
    add_column :products, :active, :boolean
    add_column :products, :shown, :boolean
  end
end

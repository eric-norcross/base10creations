class AddComponentIdToProducts < ActiveRecord::Migration
  def change
    add_column :products, :component_id, :integer
  end
end

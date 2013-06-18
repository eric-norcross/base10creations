class AddSubcomponentIdToProducts < ActiveRecord::Migration
  def change
    add_column :products, :subcomponent_id, :integer
  end
end

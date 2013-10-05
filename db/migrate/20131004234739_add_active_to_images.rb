class AddActiveToImages < ActiveRecord::Migration
  def change
    add_column :images, :active, :boolean
  end
end

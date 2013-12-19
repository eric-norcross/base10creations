class AddActiveToSections < ActiveRecord::Migration
  def change
    add_column :sections, :active, :boolean
  end
end

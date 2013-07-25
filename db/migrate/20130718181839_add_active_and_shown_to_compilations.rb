class AddActiveAndShownToCompilations < ActiveRecord::Migration
  def change
    add_column :compilations, :active, :boolean
    add_column :compilations, :shown, :boolean
  end
end

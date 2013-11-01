class AddDefaultToImages < ActiveRecord::Migration
  def change
    change_column :images, :active, :boolean, :default => true
  end
end

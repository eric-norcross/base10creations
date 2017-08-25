class AddShownToSection < ActiveRecord::Migration[5.1]
  def change
    add_column :sections, :shown, :boolean, default: true, null: false
  end
end

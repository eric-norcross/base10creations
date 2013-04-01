class AddSkinIdToSection < ActiveRecord::Migration
  def change
    add_column :sections, :skin_id, :integer
  end
end

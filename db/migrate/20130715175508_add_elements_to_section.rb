class AddElementsToSection < ActiveRecord::Migration
  def change
    add_column :sections, :content, :text
    add_column :sections, :parent_id, :integer
    add_column :sections, :skin_id, :integer
  end
end

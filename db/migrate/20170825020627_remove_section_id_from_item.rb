class RemoveSectionIdFromItem < ActiveRecord::Migration[5.1]
  def change
    remove_column :items, :section_id
  end
end

class RenameSectionIdToParentId < ActiveRecord::Migration[5.1]
  def change
    rename_column :sections, :section_id, :parent_id
  end
end

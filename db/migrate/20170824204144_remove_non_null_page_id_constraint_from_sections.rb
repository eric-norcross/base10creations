class RemoveNonNullPageIdConstraintFromSections < ActiveRecord::Migration[5.1]
  def change
    change_column :sections, :page_id, :integer, null: true
  end
end

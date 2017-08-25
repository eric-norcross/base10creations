class AddParentToSections < ActiveRecord::Migration[5.1]
  def change
    add_reference :sections, :section, index: true, foreign_key: true, null: true
  end
end

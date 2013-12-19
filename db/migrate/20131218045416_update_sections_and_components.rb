class UpdateSectionsAndComponents < ActiveRecord::Migration
  def change
    add_column :components, :active, :boolean, :default => true
    change_column :sections, :active, :boolean, :default => true

    Component.update_all ["active = ?", true]
    Section.update_all ["active = ?", true]
  end
end

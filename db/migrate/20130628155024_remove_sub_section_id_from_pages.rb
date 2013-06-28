class RemoveSubSectionIdFromPages < ActiveRecord::Migration
  def up
    remove_column :pages, :subsection_id
  end

  def down
    add_column :pages, :subsection_id, :string
  end
end

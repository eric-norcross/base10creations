class RemoveLinksFromImages < ActiveRecord::Migration
  def up
    remove_column :images, :link
  end

  def down
    add_column :images, :link, :string
  end
end

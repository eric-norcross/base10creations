class ChangeFigures < ActiveRecord::Migration
  def change
    remove_column :figures, :link
    rename_column :figures, :title, :caption
    add_column    :images, :link, :text
  end
end

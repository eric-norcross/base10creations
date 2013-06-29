class AddLinkToFigures < ActiveRecord::Migration
  def change
    add_column :figures, :link, :text
  end
end

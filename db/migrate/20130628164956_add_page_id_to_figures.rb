class AddPageIdToFigures < ActiveRecord::Migration
  def change
    add_column :figures, :page_id, :integer
  end
end

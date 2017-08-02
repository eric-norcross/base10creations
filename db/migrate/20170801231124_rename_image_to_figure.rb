class RenameImageToFigure < ActiveRecord::Migration[5.1]
  def change
    rename_table :images, :figures
  end
end

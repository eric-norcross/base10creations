class RenameAssetToImageOnFigures < ActiveRecord::Migration[5.1]
  def change
    rename_column :figures, :asset, :image
  end
end

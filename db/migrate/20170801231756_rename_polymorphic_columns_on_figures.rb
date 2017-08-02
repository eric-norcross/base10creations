class RenamePolymorphicColumnsOnFigures < ActiveRecord::Migration[5.1]
  def change
    rename_column :figures, :imageable_type, :figureable_type
    rename_column :figures, :imageable_id, :figureable_id
  end
end

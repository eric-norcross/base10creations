class ChangeCollectionStylesTableName < ActiveRecord::Migration
  def change
    rename_table :collection_styles, :collection_style
  end
end

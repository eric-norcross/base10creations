class ChangeCollectionStyleToCollectionStyles < ActiveRecord::Migration
  def change
    rename_table :collection_style, :collection_styles
  end
end

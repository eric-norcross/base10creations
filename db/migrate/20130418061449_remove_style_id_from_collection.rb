class RemoveStyleIdFromCollection < ActiveRecord::Migration
  def change
      remove_column :collections, :style_id
  end
end

class DropCollectionComponents < ActiveRecord::Migration
  def change
    drop_table :collection_components
  end
end

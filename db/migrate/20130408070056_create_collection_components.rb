class CreateCollectionComponents < ActiveRecord::Migration
  def change
    create_table :collection_components do |t|
      t.integer :collection_id
      t.integer :component_id

      t.timestamps
    end
  end
end

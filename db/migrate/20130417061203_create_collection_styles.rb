class CreateCollectionStyles < ActiveRecord::Migration
  def change
    create_table :collection_styles do |t|
      t.integer :collection_id
      t.integer :style_id

      t.timestamps
    end
  end
end

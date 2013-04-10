class CreateCollections < ActiveRecord::Migration
  def change
    create_table :collections do |t|
      t.integer :style_id
      t.string  :name
      t.string  :title
      
      t.timestamps
    end
  end
end

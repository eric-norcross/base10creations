class CreateLinks < ActiveRecord::Migration[5.1]
  def change
    create_table :links do |t|
      t.text :uri, limit: 255, null: false
      t.string :target, limit: 255, null: true, default: "_blank"
      t.string :title, limit: 255, null: true, default: nil
      t.references :linkable, polymorphic: true, index: true
 
      t.timestamps
    end
  end
end

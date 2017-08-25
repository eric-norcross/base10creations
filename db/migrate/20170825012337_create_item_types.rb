class CreateItemTypes < ActiveRecord::Migration[5.1]
  def change
    create_table :item_types do |t|
      t.string :name, limit: 255, null: false
 
      t.timestamps
    end
  end
end

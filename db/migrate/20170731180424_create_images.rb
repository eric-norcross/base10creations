class CreateImages < ActiveRecord::Migration[5.1]
  def change
    create_table :images do |t|
      t.string :alt, limit: 255, null: true, default: nil
      t.string :title, limit: 255, null: true, default: nil
      t.references :imageable, polymorphic: true, index: true
      t.timestamps
    end
  end
end

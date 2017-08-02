class CreateItems < ActiveRecord::Migration[5.1]
  def change
    create_table :items do |t|
      t.string :name, limit: 255, null: false
      t.timestamps
    end

    add_reference :items, :section, references: :sections, index: true, null: false, foreign_key: true
  end
end

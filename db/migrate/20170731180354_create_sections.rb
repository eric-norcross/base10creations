class CreateSections < ActiveRecord::Migration[5.1]
  def change
    create_table :sections do |t|
      t.string :name, limit: 255, null: false
      t.text :content
      t.timestamps
    end
  end
end

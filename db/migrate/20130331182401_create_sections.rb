class CreateSections < ActiveRecord::Migration
  def change
    create_table :sections do |t|
      t.string :name
      t.string :title
      t.integer :category_id

      t.timestamps
    end
  end
end

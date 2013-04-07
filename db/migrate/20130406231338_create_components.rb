class CreateComponents < ActiveRecord::Migration
  def change
    create_table :components do |t|
      t.string :name
      t.string :title
      t.integer :category_id

      t.timestamps
    end
  end
end

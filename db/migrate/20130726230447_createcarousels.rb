class Createcarousels < ActiveRecord::Migration
  def change
    create_table :carousels do |t|
      t.string :name
      t.string :title
      t.integer :page_id

      t.timestamps
    end
  end
end
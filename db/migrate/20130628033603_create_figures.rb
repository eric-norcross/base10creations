class CreateFigures < ActiveRecord::Migration
  def change
    create_table :figures do |t|
      t.text :link
      t.string :title

      t.timestamps
    end
  end
end

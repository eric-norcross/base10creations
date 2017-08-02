class CreateQuotes < ActiveRecord::Migration[5.1]
  def change
    create_table :quotes do |t|
      t.string :author, limit: 255, null: false
      t.text  :quote, null: false
      t.timestamps
    end
  end
end

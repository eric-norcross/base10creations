class CreatePages < ActiveRecord::Migration[5.1]
  def change
    create_table :pages do |t|
      t.string :name

      t.timestamps
    end

    add_reference :sections, :page, references: :pages, index: true, null: false, foreign_key: true
  end
end

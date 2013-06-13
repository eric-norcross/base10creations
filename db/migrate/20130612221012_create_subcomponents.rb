class CreateSubcomponents < ActiveRecord::Migration
  def change
    create_table :subcomponents do |t|
      t.string :name
      t.string :title
      t.integer :component_id

      t.timestamps
    end
  end
end

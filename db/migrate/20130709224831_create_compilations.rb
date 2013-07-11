class CreateCompilations < ActiveRecord::Migration
  def change
    create_table :compilations do |t|
      t.string :name
      t.string :title
      t.integer :skin_id
      t.integer :collection_id
      t.integer :component_id
      t.integer :subcomponent_id

      t.timestamps
    end

    add_column :products, :compilation_id, :integer
  end
end

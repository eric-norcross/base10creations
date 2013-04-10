class CreateComponentStyles < ActiveRecord::Migration
  def change
    create_table :component_styles do |t|
      t.integer :style_id
      t.integer :component_id

      t.timestamps
    end
  end
end

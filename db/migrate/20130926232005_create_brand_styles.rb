class CreateBrandStyles < ActiveRecord::Migration
  def change
    create_table :brand_styles do |t|
      t.integer :brand_id
      t.integer :style_id

      t.timestamps
    end

    add_index :brand_styles, :brand_id
    add_index :brand_styles, :style_id
    add_index :brand_styles, [:brand_id, :style_id], unique: true
  end
end

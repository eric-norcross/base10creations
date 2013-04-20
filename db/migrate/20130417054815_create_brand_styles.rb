class CreateBrandStyles < ActiveRecord::Migration
  def change
    create_table :brand_styles do |t|
      t.integer :brand_id
      t.integer :style_id

      t.timestamps
    end
  end
end

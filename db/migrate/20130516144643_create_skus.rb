class CreateSkus < ActiveRecord::Migration
  def change
    create_table :skus do |t|
      t.string :identifier
      t.integer :product_id
      t.integer :finish_id
      t.timestamps
    end
  end
end

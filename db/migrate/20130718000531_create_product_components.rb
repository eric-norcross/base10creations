class CreateProductComponents < ActiveRecord::Migration
  def change
    create_table :product_components do |t|

      t.timestamps
    end
  end
end

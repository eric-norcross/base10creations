class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.string :name
      t.string :address
      t.string :city
      t.string :province
      t.string :postal_code
      t.string :country
      t.integer :phone
      t.integer :ext
      t.integer :phone_alt
      t.integer :ext_alt
      t.float :latitude
      t.float :longitude

      t.timestamps
    end
  end
end

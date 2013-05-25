class AddImageToDimensions < ActiveRecord::Migration
  def change
    add_column :dimensions, :image, :string
  end
end

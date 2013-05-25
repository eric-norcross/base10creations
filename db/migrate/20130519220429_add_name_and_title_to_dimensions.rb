class AddNameAndTitleToDimensions < ActiveRecord::Migration
  def change
    add_column :dimensions, :name, :string
    add_column :dimensions, :title, :string
  end
end

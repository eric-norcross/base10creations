class AddContentToSection < ActiveRecord::Migration
  def change
    add_column :sections, :content, :string
  end
end

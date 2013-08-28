class AddLinkToSection < ActiveRecord::Migration
  def change
    add_column :sections, :link, :string
  end
end

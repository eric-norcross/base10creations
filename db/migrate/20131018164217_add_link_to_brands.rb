class AddLinkToBrands < ActiveRecord::Migration
  def change
    add_column :brands, :link, :string
  end
end

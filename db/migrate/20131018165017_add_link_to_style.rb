class AddLinkToStyle < ActiveRecord::Migration
  def change
    add_column :styles, :link, :string
  end
end

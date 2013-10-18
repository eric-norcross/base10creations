class AddLinkToCollection < ActiveRecord::Migration
  def change
    add_column :collections, :link, :string
  end
end

class RemoveContentFromImages < ActiveRecord::Migration
  def change
    remove_column :images, :content
  end
end

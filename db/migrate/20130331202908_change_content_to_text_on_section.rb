class ChangeContentToTextOnSection < ActiveRecord::Migration
  def change
    change_column :sections, :content, :text
  end
end

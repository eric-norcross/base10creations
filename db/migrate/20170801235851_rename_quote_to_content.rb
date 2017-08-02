class RenameQuoteToContent < ActiveRecord::Migration[5.1]
  def change
    rename_column :quotes, :quote, :content
  end
end

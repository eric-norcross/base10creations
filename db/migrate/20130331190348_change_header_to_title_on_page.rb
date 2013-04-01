class ChangeHeaderToTitleOnPage < ActiveRecord::Migration
  def change
    rename_column :pages, :header, :title
  end
end

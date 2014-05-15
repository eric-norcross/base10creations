class AddSkinIdToPages < ActiveRecord::Migration
  def change
    add_column :pages, :skin_id, :integer
  end
end

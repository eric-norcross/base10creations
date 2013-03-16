class AddGroupToPages < ActiveRecord::Migration
  def change
    add_column :pages, :group, :string
  end
end

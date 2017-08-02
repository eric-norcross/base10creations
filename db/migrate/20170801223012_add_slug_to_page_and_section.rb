class AddSlugToPageAndSection < ActiveRecord::Migration[5.1]
  def change
    add_column :pages, :slug, :string, null: false
    add_column :sections, :slug, :string, null: false
  end
end

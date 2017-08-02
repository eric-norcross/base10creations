class AddSlugIndexing < ActiveRecord::Migration[5.1]
  def change
    add_index :pages, :slug, unique: true
    add_index :sections, :slug, unique: true
  end
end

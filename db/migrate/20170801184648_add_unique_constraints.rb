class AddUniqueConstraints < ActiveRecord::Migration[5.1]
  def change
    add_index :pages, [:name], unique: true
  end
end

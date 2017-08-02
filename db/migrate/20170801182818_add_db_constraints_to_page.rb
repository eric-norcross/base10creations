class AddDbConstraintsToPage < ActiveRecord::Migration[5.1]
  def change
    change_column :pages, :name, :string, limit: 255, null: false
  end
end

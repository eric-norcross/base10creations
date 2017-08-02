class AddFirstAndLastNameToAdmin < ActiveRecord::Migration[5.1]
  def change
    add_column :admins, :first_name, :string, limit: 255, null: false
    add_column :admins, :last_name, :string, limit: 255, null: false
  end
end

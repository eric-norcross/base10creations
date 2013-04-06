class ChangeTypeToKind < ActiveRecord::Migration
  def change
    rename_column :categories, :type, :kind
  end
end

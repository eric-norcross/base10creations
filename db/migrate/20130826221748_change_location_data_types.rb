class ChangeLocationDataTypes < ActiveRecord::Migration
  def change
    change_column :locations, :phone, :bigint
    change_column :locations, :phone_alt, :bigint
    change_column :locations, :ext, :bigint
    change_column :locations, :ext_alt, :bigint
  end
end

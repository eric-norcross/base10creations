class RemoveSubcomponents < ActiveRecord::Migration
  def change
    drop_table :subcomponents
  end
end

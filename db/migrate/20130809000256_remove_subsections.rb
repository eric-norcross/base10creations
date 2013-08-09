class RemoveSubsections < ActiveRecord::Migration
  def change
    drop_table :subsections
  end
end

class AddFinishIdToCompilations < ActiveRecord::Migration
  def change
    add_column :compilations, :finish_id, :integer
  end
end

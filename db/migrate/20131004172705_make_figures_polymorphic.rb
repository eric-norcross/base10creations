class MakeFiguresPolymorphic < ActiveRecord::Migration
  def up
    change_table :figures do |t|
      t.references :figurable, :polymorphic => true
    end
  end

  def down
    remove_column :figures, :figurable_type
    remove_column :figures, :figurable_id
  end
end

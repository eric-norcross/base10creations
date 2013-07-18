class AddParentIdToComponents < ActiveRecord::Migration
  def change
    add_column :components, :parent_id, :integer
  end
end

class RemovePolymoprhismFromItems < ActiveRecord::Migration[5.1]
  def change
    add_reference :items, :section, references: :sections, index: true, null: false, foreign_key: true, default: 1
  
    Item.reset_column_information
    Item.all.each do |item|
      item.update_attributes(section_id: item.itemable_id)
    end

    remove_column :items, :itemable_id
    remove_column :items, :itemable_type

  end
end

class ConvertItemsToPolymorphic < ActiveRecord::Migration[5.1]
  def change
    change_table :items do |t|
      t.references :itemable, polymorphic: true, index: true
    end

    add_reference :items, :item_type, references: :item_types, index: true, null: false, foreign_key: true, default: 1
  end
end


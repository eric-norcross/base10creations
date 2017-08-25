class CreateSectionTypes < ActiveRecord::Migration[5.1]
  def change
    create_table :section_types do |t|
      t.string :name, limit: 255, null: false

      t.timestamps
    end

    SectionType.reset_column_information
    SectionType.find_or_create_by!(name: "info")

    add_reference :sections, :section_type, references: :section_types, index: true, null: false, foreign_key: true, default: 1
  end
end

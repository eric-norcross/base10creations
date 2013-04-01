class AddSectionToPage < ActiveRecord::Migration
  def change
    add_column :pages, :section_id, :integer
  end
end

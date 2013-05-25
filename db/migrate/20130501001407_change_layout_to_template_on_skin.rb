class ChangeLayoutToTemplateOnSkin < ActiveRecord::Migration
  def change
    rename_column :skins, :layout, :template
  end
end

class AddIFrameUrlToPages < ActiveRecord::Migration
  def change
    add_column :pages, :iframe_url, :string
  end
end

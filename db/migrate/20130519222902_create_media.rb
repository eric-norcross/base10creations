class CreateMedia < ActiveRecord::Migration
  def change
    create_table :media do |t|
      t.string :name
      t.string :title
      t.string :content

      t.timestamps
    end
  end
end

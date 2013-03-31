class InitialSetup < ActiveRecord::Migration
  def up
    create_table "pages", :force => true do |t|
      t.string   "name"
      t.string   "header"
      t.datetime "created_at", :null => false
      t.datetime "updated_at", :null => false
      t.string   "skin_id"
    end

    create_table "products", :force => true do |t|
      t.text     "name"
      t.text     "sku"
      t.datetime "created_at", :null => false
      t.datetime "updated_at", :null => false
      t.integer  "skin_id"
    end

    create_table "skins", :force => true do |t|
      t.text     "name"
      t.text     "template"
      t.datetime "created_at", :null => false
      t.datetime "updated_at", :null => false
    end
  end

  def down
    drop_table :pages
    drop_table :products
    drop_table :skins
  end
end

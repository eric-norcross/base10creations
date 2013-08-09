# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130809001045) do

  create_table "assets", :force => true do |t|
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
    t.integer  "product_id"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

  create_table "brands", :force => true do |t|
    t.string   "name"
    t.string   "title"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "carousels", :force => true do |t|
    t.string   "name"
    t.string   "title"
    t.integer  "page_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.string   "title"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "ckeditor_assets", :force => true do |t|
    t.string   "data_file_name",                  :null => false
    t.string   "data_content_type"
    t.integer  "data_file_size"
    t.integer  "assetable_id"
    t.string   "assetable_type",    :limit => 30
    t.string   "type",              :limit => 30
    t.integer  "width"
    t.integer  "height"
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
  end

  add_index "ckeditor_assets", ["assetable_type", "assetable_id"], :name => "idx_ckeditor_assetable"
  add_index "ckeditor_assets", ["assetable_type", "type", "assetable_id"], :name => "idx_ckeditor_assetable_type"

  create_table "collection_styles", :force => true do |t|
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.integer  "collection_id"
    t.integer  "style_id"
  end

  create_table "collections", :force => true do |t|
    t.string   "name"
    t.string   "title"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.text     "description"
  end

  create_table "compilations", :force => true do |t|
    t.string   "name"
    t.string   "title"
    t.integer  "skin_id"
    t.integer  "collection_id"
    t.integer  "component_id"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
    t.boolean  "active"
    t.integer  "finish_id"
    t.boolean  "include_finish_name"
  end

  create_table "components", :force => true do |t|
    t.string   "name"
    t.string   "title"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.integer  "category_id"
    t.integer  "parent_id"
  end

  create_table "dimensions", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.float    "width"
    t.float    "height"
    t.float    "depth"
    t.integer  "product_id"
    t.string   "name"
    t.string   "title"
  end

  create_table "figures", :force => true do |t|
    t.string   "caption"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.integer  "page_id"
    t.text     "link"
    t.integer  "carousel_id"
  end

  create_table "finishes", :force => true do |t|
    t.string   "name"
    t.string   "title"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "images", :force => true do |t|
    t.integer  "imageable_id"
    t.string   "imageable_type"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.string   "asset"
  end

  add_index "images", ["imageable_id", "imageable_type"], :name => "index_images_on_imageable_id_and_imageable_type"

  create_table "pages", :force => true do |t|
    t.string   "name"
    t.string   "title"
    t.text     "content"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "skin_id"
  end

  create_table "product_components", :force => true do |t|
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.integer  "product_id"
    t.integer  "component_id"
  end

  create_table "products", :force => true do |t|
    t.text     "name"
    t.text     "title"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
    t.integer  "collection_id"
    t.integer  "skin_id"
    t.text     "style"
    t.string   "video"
    t.text     "features"
    t.boolean  "active"
    t.boolean  "shown"
    t.boolean  "include_finish_name"
  end

  create_table "sections", :force => true do |t|
    t.string   "name"
    t.string   "title"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.text     "content"
    t.integer  "parent_id"
    t.integer  "skin_id"
  end

  create_table "skins", :force => true do |t|
    t.text     "name"
    t.text     "title"
    t.text     "template"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "skus", :force => true do |t|
    t.integer  "product_id"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.integer  "finish_id"
    t.string   "name"
    t.string   "title"
    t.integer  "compilation_id"
  end

  create_table "styles", :force => true do |t|
    t.string   "name"
    t.string   "title"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.integer  "brand_id"
    t.text     "description"
  end

end

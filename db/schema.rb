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

ActiveRecord::Schema.define(:version => 20140125022935) do

  create_table "admins", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "admins", ["email"], :name => "index_admins_on_email", :unique => true
  add_index "admins", ["reset_password_token"], :name => "index_admins_on_reset_password_token", :unique => true

  create_table "assets", :force => true do |t|
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
    t.integer  "product_id"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

  create_table "brand_collections", :force => true do |t|
    t.integer  "brand_id"
    t.integer  "collection_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "brand_collections", ["brand_id", "collection_id"], :name => "index_brand_collections_on_brand_id_and_collection_id", :unique => true
  add_index "brand_collections", ["brand_id"], :name => "index_brand_collections_on_brand_id"
  add_index "brand_collections", ["collection_id"], :name => "index_brand_collections_on_collection_id"

  create_table "brand_styles", :force => true do |t|
    t.integer  "brand_id"
    t.integer  "style_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "brand_styles", ["brand_id", "style_id"], :name => "index_brand_styles_on_brand_id_and_style_id", :unique => true
  add_index "brand_styles", ["brand_id"], :name => "index_brand_styles_on_brand_id"
  add_index "brand_styles", ["style_id"], :name => "index_brand_styles_on_style_id"

  create_table "brands", :force => true do |t|
    t.string   "name"
    t.string   "title"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.text     "description"
    t.string   "link"
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
    t.string   "link"
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

  add_index "collection_styles", ["collection_id", "style_id"], :name => "index_collection_styles_on_collection_id_and_style_id", :unique => true
  add_index "collection_styles", ["collection_id"], :name => "index_collection_styles_on_collection_id"
  add_index "collection_styles", ["style_id"], :name => "index_collection_styles_on_style_id"

  create_table "collections", :force => true do |t|
    t.string   "name"
    t.string   "title"
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
    t.text     "description"
    t.string   "link"
    t.integer  "parent_id",   :default => 0
  end

  create_table "compilation_skus", :force => true do |t|
    t.integer  "compilation_id"
    t.integer  "sku_id"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  add_index "compilation_skus", ["compilation_id", "sku_id"], :name => "index_compilation_skus_on_compilation_id_and_sku_id", :unique => true
  add_index "compilation_skus", ["compilation_id"], :name => "index_compilation_skus_on_compilation_id"
  add_index "compilation_skus", ["sku_id"], :name => "index_compilation_skus_on_sku_id"

  create_table "compilations", :force => true do |t|
    t.string   "name"
    t.string   "title"
    t.integer  "skin_id"
    t.integer  "collection_id"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
    t.boolean  "active"
    t.integer  "finish_id"
    t.boolean  "include_finish_name"
  end

  create_table "components", :force => true do |t|
    t.string   "name"
    t.string   "title"
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
    t.integer  "category_id"
    t.integer  "parent_id"
    t.boolean  "active",      :default => true
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

  create_table "editors", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "editors", ["email"], :name => "index_editors_on_email", :unique => true
  add_index "editors", ["reset_password_token"], :name => "index_editors_on_reset_password_token", :unique => true

  create_table "figures", :force => true do |t|
    t.string   "caption"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.text     "link"
    t.integer  "figurable_id"
    t.string   "figurable_type"
  end

  add_index "figures", ["figurable_id", "figurable_type"], :name => "index_figures_on_figurable_id_and_figurable_type"

  create_table "finishes", :force => true do |t|
    t.string   "name"
    t.string   "title"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "images", :force => true do |t|
    t.integer  "imageable_id"
    t.string   "imageable_type"
    t.datetime "created_at",                       :null => false
    t.datetime "updated_at",                       :null => false
    t.string   "asset"
    t.boolean  "active",         :default => true
  end

  add_index "images", ["imageable_id", "imageable_type"], :name => "index_images_on_imageable_id_and_imageable_type"

  create_table "locations", :force => true do |t|
    t.string   "name"
    t.string   "address"
    t.string   "city"
    t.string   "province"
    t.string   "postal_code"
    t.string   "country"
    t.integer  "phone",       :limit => 8
    t.integer  "ext",         :limit => 8
    t.integer  "phone_alt",   :limit => 8
    t.integer  "ext_alt",     :limit => 8
    t.float    "latitude"
    t.float    "longitude"
    t.datetime "created_at",               :null => false
    t.datetime "updated_at",               :null => false
    t.string   "url"
    t.boolean  "gmaps"
    t.string   "match_type"
  end

  create_table "pages", :force => true do |t|
    t.string   "name"
    t.string   "title"
    t.text     "content"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "skin_id"
    t.string   "iframe_url"
  end

  create_table "pg_search_documents", :force => true do |t|
    t.text     "content"
    t.integer  "searchable_id"
    t.string   "searchable_type"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "product_components", :force => true do |t|
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.integer  "product_id"
    t.integer  "component_id"
  end

  add_index "product_components", ["component_id"], :name => "index_product_components_on_component_id"
  add_index "product_components", ["product_id", "component_id"], :name => "index_product_components_on_product_id_and_component_id", :unique => true
  add_index "product_components", ["product_id"], :name => "index_product_components_on_product_id"

  create_table "products", :force => true do |t|
    t.text     "name"
    t.text     "title"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
    t.integer  "collection_id"
    t.integer  "skin_id"
    t.text     "features"
    t.boolean  "active"
    t.boolean  "shown"
    t.boolean  "include_finish_name"
  end

  create_table "sections", :force => true do |t|
    t.string   "name"
    t.string   "title"
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at",                   :null => false
    t.text     "content"
    t.integer  "parent_id"
    t.integer  "skin_id"
    t.string   "link"
    t.boolean  "active",     :default => true
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
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "finish_id"
    t.string   "name"
    t.string   "title"
  end

  create_table "styles", :force => true do |t|
    t.string   "name"
    t.string   "title"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.text     "description"
    t.string   "link"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "videos", :force => true do |t|
    t.string   "url"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "product_id"
  end

end

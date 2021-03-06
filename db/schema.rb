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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20200824181122) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admins", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "first_name", limit: 255, null: false
    t.string "last_name", limit: 255, null: false
    t.index ["email"], name: "index_admins_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true
  end

  create_table "ckeditor_assets", force: :cascade do |t|
    t.string "data_file_name", null: false
    t.string "data_content_type"
    t.integer "data_file_size"
    t.string "type", limit: 30
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["type"], name: "index_ckeditor_assets_on_type"
  end

  create_table "figures", force: :cascade do |t|
    t.string "alt", limit: 255
    t.string "title", limit: 255
    t.string "figureable_type"
    t.bigint "figureable_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "image", null: false
    t.index ["figureable_type", "figureable_id"], name: "index_figures_on_figureable_type_and_figureable_id"
  end

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string "slug", null: false
    t.integer "sluggable_id", null: false
    t.string "sluggable_type", limit: 50
    t.string "scope"
    t.datetime "created_at"
    t.index ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true
    t.index ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type"
    t.index ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id"
    t.index ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type"
  end

  create_table "items", force: :cascade do |t|
    t.string "name", limit: 255, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "section_id", default: 1, null: false
    t.index ["section_id"], name: "index_items_on_section_id"
  end

  create_table "links", force: :cascade do |t|
    t.text "uri", null: false
    t.string "target", limit: 255, default: "_blank"
    t.string "title", limit: 255
    t.string "linkable_type"
    t.bigint "linkable_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["linkable_type", "linkable_id"], name: "index_links_on_linkable_type_and_linkable_id"
  end

  create_table "pages", force: :cascade do |t|
    t.string "name", limit: 255, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "slug", null: false
    t.index ["name"], name: "index_pages_on_name", unique: true
    t.index ["slug"], name: "index_pages_on_slug", unique: true
  end

  create_table "quotes", force: :cascade do |t|
    t.string "author", limit: 255, null: false
    t.text "content", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "section_types", force: :cascade do |t|
    t.string "name", limit: 255, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "sections", force: :cascade do |t|
    t.string "name", limit: 255, null: false
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "page_id"
    t.string "slug", null: false
    t.bigint "parent_id"
    t.bigint "section_type_id", default: 1, null: false
    t.boolean "shown", default: true, null: false
    t.index ["page_id"], name: "index_sections_on_page_id"
    t.index ["parent_id"], name: "index_sections_on_parent_id"
    t.index ["section_type_id"], name: "index_sections_on_section_type_id"
    t.index ["slug"], name: "index_sections_on_slug", unique: true
  end

  create_table "trackers", force: :cascade do |t|
    t.string "remote_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "items", "sections"
  add_foreign_key "sections", "pages"
  add_foreign_key "sections", "section_types"
  add_foreign_key "sections", "sections", column: "parent_id"
end

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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20140212080206) do

  create_table "brand_addrs", force: true do |t|
    t.string   "link_addr"
    t.string   "description"
    t.integer  "brand_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "brands", force: true do |t|
    t.string   "brand_chinese"
    t.string   "brand_english"
    t.integer  "country_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "brands", ["brand_chinese", "brand_english"], name: "index_brands_on_brand_chinese_and_brand_english", unique: true
  add_index "brands", ["brand_chinese"], name: "index_brands_on_brand_chinese", unique: true
  add_index "brands", ["brand_english"], name: "index_brands_on_brand_english", unique: true

  create_table "categories", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "step"
  end

  add_index "categories", ["name"], name: "index_categories_on_name", unique: true
  add_index "categories", ["step"], name: "index_categories_on_step", unique: true

  create_table "comments", force: true do |t|
    t.integer  "item_id"
    t.string   "content"
    t.string   "author"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  create_table "countries", force: true do |t|
    t.string   "country_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "countries", ["country_name"], name: "index_countries_on_country_name"

  create_table "item_addrs", force: true do |t|
    t.string   "link_addr"
    t.string   "description"
    t.integer  "item_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "items", force: true do |t|
    t.string   "item_english"
    t.string   "item_chinese"
    t.integer  "brand_id"
    t.integer  "subcategory_id"
    t.string   "price"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "category_id"
    t.string   "character"
  end

  add_index "items", ["item_chinese"], name: "index_items_on_item_chinese"
  add_index "items", ["item_english"], name: "index_items_on_item_english"

  create_table "subcategories", force: true do |t|
    t.string   "name"
    t.integer  "category_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "step"
  end

  add_index "subcategories", ["name", "category_id"], name: "index_subcategories_on_name_and_category_id", unique: true
  add_index "subcategories", ["step"], name: "index_subcategories_on_step", unique: true

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "password_digest"
    t.string   "remember_token"
    t.boolean  "admin"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["remember_token"], name: "index_users_on_remember_token"

end

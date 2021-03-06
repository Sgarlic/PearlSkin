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

ActiveRecord::Schema.define(version: 20140222073356) do

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
    t.text     "content",    limit: 255
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

  create_table "favourites", force: true do |t|
    t.integer  "user_id"
    t.integer  "item_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "favourites", ["item_id"], name: "index_favourites_on_item_id"
  add_index "favourites", ["user_id", "item_id"], name: "index_favourites_on_user_id_and_item_id", unique: true
  add_index "favourites", ["user_id"], name: "index_favourites_on_user_id"

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
    t.binary   "image"
    t.string   "filename"
    t.string   "content_type"
  end

  add_index "items", ["item_chinese"], name: "index_items_on_item_chinese"
  add_index "items", ["item_english"], name: "index_items_on_item_english"

  create_table "likes", force: true do |t|
    t.integer  "user_id"
    t.integer  "item_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "likes", ["item_id"], name: "index_likes_on_item_id"
  add_index "likes", ["user_id", "item_id"], name: "index_likes_on_user_id_and_item_id", unique: true
  add_index "likes", ["user_id"], name: "index_likes_on_user_id"

  create_table "plans", force: true do |t|
    t.integer  "user_id"
    t.integer  "item_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "plans", ["item_id"], name: "index_plans_on_item_id"
  add_index "plans", ["user_id", "item_id"], name: "index_plans_on_user_id_and_item_id", unique: true
  add_index "plans", ["user_id"], name: "index_plans_on_user_id"

  create_table "subcategories", force: true do |t|
    t.string   "name"
    t.integer  "category_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "step"
  end

  add_index "subcategories", ["name", "category_id"], name: "index_subcategories_on_name_and_category_id", unique: true
  add_index "subcategories", ["step"], name: "index_subcategories_on_step"

  create_table "useds", force: true do |t|
    t.integer  "user_id"
    t.integer  "item_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "useds", ["item_id"], name: "index_useds_on_item_id"
  add_index "useds", ["user_id", "item_id"], name: "index_useds_on_user_id_and_item_id", unique: true
  add_index "useds", ["user_id"], name: "index_useds_on_user_id"

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

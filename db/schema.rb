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

ActiveRecord::Schema.define(version: 20151028111300) do

  create_table "categories", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "category_translations", force: :cascade do |t|
    t.integer "category_id",           null: false
    t.string  "locale",      limit: 2, null: false
    t.string  "name",                  null: false
  end

  add_index "category_translations", ["category_id", "locale"], name: "index_category_translations_on_category_id_and_locale", unique: true

  create_table "condition_translations", force: :cascade do |t|
    t.integer "condition_id",           null: false
    t.string  "locale",       limit: 2, null: false
    t.string  "name",                   null: false
  end

  add_index "condition_translations", ["condition_id", "locale"], name: "index_condition_translations_on_condition_id_and_locale", unique: true

  create_table "conditions", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "enquiries", force: :cascade do |t|
    t.integer  "item_id",    null: false
    t.string   "name"
    t.string   "email",      null: false
    t.string   "phone"
    t.text     "message"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "item_translations", force: :cascade do |t|
    t.integer "item_id",               null: false
    t.string  "locale",      limit: 2, null: false
    t.string  "name",                  null: false
    t.text    "description",           null: false
  end

  add_index "item_translations", ["item_id", "locale"], name: "index_item_translations_on_item_id_and_locale", unique: true

  create_table "items", force: :cascade do |t|
    t.integer  "price",        null: false
    t.integer  "user_id",      null: false
    t.integer  "category_id",  null: false
    t.integer  "condition_id", null: false
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "photos", force: :cascade do |t|
    t.integer  "item_id"
    t.string   "file_file_name",    null: false
    t.string   "file_content_type", null: false
    t.integer  "file_file_size",    null: false
    t.datetime "file_updated_at",   null: false
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.boolean  "is_admin",               default: false, null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

  create_table "versions", force: :cascade do |t|
    t.string   "item_type",                     null: false
    t.integer  "item_id",                       null: false
    t.string   "event",                         null: false
    t.string   "whodunnit"
    t.text     "object",     limit: 1073741823
    t.datetime "created_at"
  end

  add_index "versions", ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id"

end

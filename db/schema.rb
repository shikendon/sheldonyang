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

ActiveRecord::Schema.define(version: 20140707065245) do

  create_table "authorizations", force: true do |t|
    t.integer  "user_id"
    t.string   "provider"
    t.string   "uid"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "authorizations", ["user_id"], name: "index_authorizations_on_user_id"

  create_table "comments", force: true do |t|
    t.integer  "example_id"
    t.string   "matchtext"
    t.string   "aliastext"
    t.string   "transtext"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comments", ["example_id"], name: "index_comments_on_example_id"

  create_table "examples", force: true do |t|
    t.integer  "user_id"
    t.text     "text"
    t.boolean  "verified",   default: false, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "examples", ["user_id"], name: "index_examples_on_user_id"

  create_table "tag_i18ns", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tags", force: true do |t|
    t.integer  "example_id"
    t.integer  "tag_i18n_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tags", ["example_id"], name: "index_tags_on_example_id"
  add_index "tags", ["tag_i18n_id"], name: "index_tags_on_tag_i18n_id"

  create_table "users", force: true do |t|
    t.string   "name",               default: "", null: false
    t.string   "email",              default: "", null: false
    t.string   "encrypted_password", default: "", null: false
    t.integer  "level",              default: 0,  null: false
    t.integer  "sign_in_count",      default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true

end

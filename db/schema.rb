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

ActiveRecord::Schema.define(version: 20160412071406) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "companies_users", force: :cascade do |t|
    t.integer  "company_id"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "companies_users", ["company_id"], name: "index_as_companies_users_on_company_id", using: :btree
  add_index "companies_users", ["user_id"], name: "index_as_companies_users_on_user_id", using: :btree

  create_table "company_accounts", force: :cascade do |t|
    t.integer  "balance",    default: 100
    t.integer  "limit",      default: 0
    t.integer  "company_id"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "douglas_transfers", force: :cascade do |t|
    t.integer  "to_id"
    t.integer  "amount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "to_type"
  end

  create_table "gesell_transfers", force: :cascade do |t|
    t.integer  "from_id"
    t.integer  "amount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "from_type"
  end

  create_table "personal_accounts", force: :cascade do |t|
    t.integer  "balance",    default: 100
    t.integer  "limit",      default: -5000
    t.integer  "volume",     default: 0
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.integer  "user_id"
  end

  create_table "regular_transfers", force: :cascade do |t|
    t.integer  "from_id"
    t.string   "from_type"
    t.integer  "to_id"
    t.string   "to_type"
    t.integer  "amount"
    t.integer  "after_tax"
    t.integer  "before_volume"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.string   "title",         null: false
  end

  create_table "reset_volume_transfers", force: :cascade do |t|
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.integer  "personal_account_id"
    t.integer  "before_volume"
  end

  add_index "reset_volume_transfers", ["personal_account_id"], name: "index_reset_volume_transfers_on_personal_account_id", using: :btree

  create_table "the_accounts", force: :cascade do |t|
    t.integer  "balance",    default: 0
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "transfer_histories", force: :cascade do |t|
    t.string   "transfer_type"
    t.integer  "transfer_id"
    t.integer  "transfer_history_id"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "phone_number"
    t.integer  "phone_number_status",    default: 0
    t.string   "phone_number_code"
    t.string   "first_name",                          null: false
    t.string   "last_name",                           null: false
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "reset_volume_transfers", "personal_accounts"
end

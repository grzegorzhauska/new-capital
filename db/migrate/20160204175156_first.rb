class First < ActiveRecord::Migration
  def change
    create_table "personal_accounts", force: :cascade do |t|
      t.integer  "balance",        default: 100
      t.integer  "limit",          default: -30000
      t.integer  "volume",         default: 0
      t.datetime "created_at",     null: false
      t.datetime "updated_at",     null: false
      t.integer  "user_id"
    end

    create_table "company_accounts", force: :cascade do |t|
      t.integer  "balance",        default: 100
      t.integer  "limit",          default: 0
      t.integer  "company_id"
      t.datetime "created_at",     null: false
      t.datetime "updated_at",     null: false
    end

    create_table "the_accounts", force: :cascade do |t|
      t.integer  "balance",        default: 0
      t.datetime "created_at",     null: false
      t.datetime "updated_at",     null: false
    end

    create_table "companies_users", force: :cascade do |t|
      t.integer  "company_id"
      t.integer  "user_id"
      t.datetime "created_at",      null: false
      t.datetime "updated_at",      null: false
    end

    add_index "companies_users", ["company_id"], name: "index_as_companies_users_on_company_id", using: :btree
    add_index "companies_users", ["user_id"], name: "index_as_companies_users_on_user_id", using: :btree

    create_table "regular_transfers", force: :cascade do |t|
      t.integer  "from_id"
      t.string   "from_type"
      t.integer  "to_id"
      t.string   "to_type"
      t.integer  "amount"
      t.integer  "after_tax"
      t.integer  "before_volume"
      t.datetime "created_at",      null: false
      t.datetime "updated_at",      null: false
    end

    create_table "douglas_transfers", force: :cascade do |t|
      t.integer  "to_id"
      t.integer  "amount"
      t.datetime "created_at",      null: false
      t.datetime "updated_at",      null: false
    end

    create_table "gesell_transfers", force: :cascade do |t|
      t.integer  "from_id"
      t.integer  "amount"
      t.datetime "created_at",      null: false
      t.datetime "updated_at",      null: false
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
      t.datetime "created_at",             null: false
      t.datetime "updated_at",             null: false
    end

    add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
    add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end
end

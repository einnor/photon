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

ActiveRecord::Schema.define(version: 20140814131454) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "chamas", force: true do |t|
    t.string   "name"
    t.string   "description"
    t.string   "chama_type"
    t.integer  "approx_no_of_members"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "chamas", ["user_id"], name: "index_chamas_on_user_id", using: :btree

  create_table "loan_repayments", force: true do |t|
    t.float    "amount"
    t.integer  "loan_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "loan_repayments", ["loan_id"], name: "index_loan_repayments_on_loan_id", using: :btree

  create_table "loans", force: true do |t|
    t.float    "loan_amount_requested"
    t.integer  "repay_period_in_months"
    t.float    "interest_rate_pa"
    t.string   "loan_interest_method"
    t.float    "monthly_installments"
    t.float    "repay_amount"
    t.string   "loan_status"
    t.date     "installment_repay_deadline"
    t.integer  "member_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "loans", ["member_id"], name: "index_loans_on_member_id", using: :btree

  create_table "members", force: true do |t|
    t.string   "name"
    t.string   "phone_number"
    t.string   "occupation"
    t.string   "national_id_number"
    t.text     "others"
    t.integer  "chama_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "members", ["chama_id"], name: "index_members_on_chama_id", using: :btree

  create_table "penalties", force: true do |t|
    t.string   "penalty_type"
    t.float    "amount"
    t.date     "due_date"
    t.string   "penalty_status"
    t.integer  "member_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "penalties", ["member_id"], name: "index_penalties_on_member_id", using: :btree

  create_table "penalty_repayments", force: true do |t|
    t.float    "amount"
    t.integer  "penalty_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "penalty_repayments", ["penalty_id"], name: "index_penalty_repayments_on_penalty_id", using: :btree

  create_table "remittances", force: true do |t|
    t.float    "amount"
    t.string   "remittance_type"
    t.integer  "member_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "remittances", ["member_id"], name: "index_remittances_on_member_id", using: :btree

  create_table "roles", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles_users", id: false, force: true do |t|
    t.integer "role_id"
    t.integer "user_id"
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name",                   default: "", null: false
    t.string   "phone_number",           default: "", null: false
    t.string   "national_id_number",     default: "", null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end

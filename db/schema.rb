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

ActiveRecord::Schema.define(version: 20160811203800) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "notification_profiles", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "email"
    t.string   "sms"
    t.string   "slack"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_notification_profiles_on_user_id", using: :btree
  end

  create_table "notifications", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "test_suite_id"
    t.boolean  "slack"
    t.boolean  "email"
    t.boolean  "sms"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["test_suite_id"], name: "index_notifications_on_test_suite_id", using: :btree
    t.index ["user_id"], name: "index_notifications_on_user_id", using: :btree
  end

  create_table "test_case_runs", force: :cascade do |t|
    t.integer  "test_case_id"
    t.integer  "status"
    t.string   "status_msg"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.integer  "test_suite_run_id"
    t.float    "time"
    t.index ["test_case_id"], name: "index_test_case_runs_on_test_case_id", using: :btree
    t.index ["test_suite_run_id"], name: "index_test_case_runs_on_test_suite_run_id", using: :btree
  end

  create_table "test_cases", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "test_suite_id"
    t.index ["name", "test_suite_id"], name: "index_test_cases_on_name_and_test_suite_id", unique: true, using: :btree
    t.index ["test_suite_id"], name: "index_test_cases_on_test_suite_id", using: :btree
  end

  create_table "test_suite_runs", force: :cascade do |t|
    t.integer  "tests"
    t.integer  "failures"
    t.integer  "errs"
    t.integer  "skipped"
    t.datetime "timestamp"
    t.integer  "test_suite_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.float    "time"
    t.index ["test_suite_id"], name: "index_test_suite_runs_on_test_suite_id", using: :btree
    t.index ["timestamp", "test_suite_id"], name: "index_test_suite_runs_on_timestamp_and_test_suite_id", unique: true, using: :btree
  end

  create_table "test_suites", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "task_name"
    t.index ["name"], name: "index_test_suites_on_name", unique: true, using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.text     "first_name"
    t.text     "last_name"
    t.text     "username"
    t.text     "email_address"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.text     "role"
    t.index ["username"], name: "index_users_on_username", unique: true, using: :btree
  end

  add_foreign_key "notification_profiles", "users"
  add_foreign_key "notifications", "test_suites"
  add_foreign_key "notifications", "users"
  add_foreign_key "test_case_runs", "test_cases"
  add_foreign_key "test_case_runs", "test_suite_runs"
  add_foreign_key "test_cases", "test_suites"
  add_foreign_key "test_suite_runs", "test_suites"
end

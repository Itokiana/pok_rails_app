# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_12_23_052906) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accounts", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_accounts_on_email", unique: true
    t.index ["reset_password_token"], name: "index_accounts_on_reset_password_token", unique: true
  end

  create_table "admins", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "superadmin_role"
    t.boolean "supervisor_role"
    t.boolean "user_role"
    t.index ["email"], name: "index_admins_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true
  end

  create_table "horodator_schedules", force: :cascade do |t|
    t.integer "end_status"
    t.bigint "user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_horodator_schedules_on_user_id"
  end

  create_table "inactivities", force: :cascade do |t|
    t.integer "mouse_x"
    t.integer "mouse_y"
    t.datetime "since"
    t.integer "total"
    t.bigint "horodator_schedule_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["horodator_schedule_id"], name: "index_inactivities_on_horodator_schedule_id"
  end

  create_table "teams", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "time_checks", force: :cascade do |t|
    t.integer "application"
    t.integer "inactivity"
    t.integer "inactivity_part"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "url_visiteds", force: :cascade do |t|
    t.string "url"
    t.datetime "date_of_visit"
    t.datetime "end_of_visit"
    t.integer "focus"
    t.datetime "start_focus"
    t.datetime "end_focus"
    t.integer "total_focus"
    t.bigint "horodator_schedule_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["horodator_schedule_id"], name: "index_url_visiteds_on_horodator_schedule_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "password_digest"
    t.string "auth_tokens"
    t.string "ip"
    t.string "mac"
    t.datetime "start"
    t.bigint "team_id"
    t.string "first_name"
    t.string "last_name"
    t.index ["team_id"], name: "index_users_on_team_id"
  end

  create_table "windows", force: :cascade do |t|
    t.string "title"
    t.string "platform"
    t.integer "x"
    t.integer "y"
    t.integer "width_screen"
    t.integer "height_screen"
    t.datetime "started_at"
    t.datetime "ended_at"
    t.integer "total_focus"
    t.bigint "horodator_schedule_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["horodator_schedule_id"], name: "index_windows_on_horodator_schedule_id"
  end

  add_foreign_key "users", "teams"
end

# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.0].define(version: 2025_10_21_021653) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "admins", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "full_name"
    t.string "uid"
    t.string "avatar_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_admins_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true
    t.index ["uid"], name: "index_admins_on_uid", unique: true
  end

  create_table "calendars", force: :cascade do |t|
    t.string "title"
    t.datetime "event_date"
    t.text "description"
    t.string "location"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "category"
    t.uuid "user_id"
    t.index ["user_id"], name: "index_calendars_on_user_id"
  end

  create_table "categories", force: :cascade do |t|
    t.string "name", limit: 100, null: false
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_categories_on_name", unique: true
  end

  create_table "event_categories", id: false, force: :cascade do |t|
    t.bigint "event_id", null: false
    t.bigint "category_id", null: false
    t.index ["event_id", "category_id"], name: "index_event_categories_on_event_id_and_category_id", unique: true
  end

  create_table "event_signups", force: :cascade do |t|
    t.string "user_email"
    t.string "user_name"
    t.bigint "calendar_id", null: false
    t.datetime "signed_up_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["calendar_id"], name: "index_event_signups_on_calendar_id"
  end

  create_table "events", force: :cascade do |t|
    t.string "title", limit: 200, null: false
    t.text "description"
    t.datetime "start_at", null: false
    t.datetime "end_at", null: false
    t.string "location", limit: 255
    t.integer "capacity"
    t.string "visibility", default: "public", null: false
    t.integer "point_value", default: 0, null: false
    t.uuid "created_by_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["created_by_id"], name: "index_events_on_created_by_id"
  end

  create_table "signups", force: :cascade do |t|
    t.bigint "event_id", null: false
    t.uuid "user_id", null: false
    t.string "rsvp_status", default: "confirmed", null: false
    t.datetime "checked_in_at"
    t.boolean "attended", default: false, null: false
    t.integer "points_awarded", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id", "user_id"], name: "index_signups_on_event_id_and_user_id", unique: true
    t.index ["event_id"], name: "index_signups_on_event_id"
    t.index ["user_id"], name: "index_signups_on_user_id"
  end

  create_table "users", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "first_name", limit: 100
    t.string "last_name", limit: 100
    t.string "email", limit: 255, null: false
    t.string "role", default: "member", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "full_name"
    t.string "uid"
    t.string "avatar_url"
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "calendars", "users"
  add_foreign_key "event_categories", "categories"
  add_foreign_key "event_categories", "events"
  add_foreign_key "event_signups", "calendars"
  add_foreign_key "signups", "events"
  add_foreign_key "signups", "users"
end

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

ActiveRecord::Schema.define(version: 2019_04_02_155327) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "alerts", force: :cascade do |t|
    t.string "name"
    t.integer "frequency"
    t.date "date"
    t.string "day", default: ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"], array: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "relationship_id"
  end

  create_table "relationships", force: :cascade do |t|
    t.integer "friender_id"
    t.integer "friendee_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "username"
    t.string "email"
    t.string "avatar"
    t.text "bio"
    t.string "default_type"
    t.integer "default_frequency"
    t.bigint "friender_id"
    t.bigint "friendee_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["friendee_id"], name: "index_users_on_friendee_id"
    t.index ["friender_id"], name: "index_users_on_friender_id"
  end

end

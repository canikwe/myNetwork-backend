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

ActiveRecord::Schema.define(version: 2019_10_15_010306) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "contacts", force: :cascade do |t|
    t.integer "user_id"
    t.integer "requested_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "kind"
    t.text "details"
    t.string "first_name"
    t.string "last_name"
  end

  create_table "goals", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.datetime "due_date"
    t.boolean "complete", default: false
    t.datetime "comeplete_date"
    t.string "originator_type"
    t.bigint "originator_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["originator_type", "originator_id"], name: "index_goals_on_originator_type_and_originator_id"
  end

  create_table "reminders", force: :cascade do |t|
    t.string "msg"
    t.datetime "start_date"
    t.integer "interval"
    t.string "period"
    t.boolean "snoozed", default: false
    t.date "current"
    t.integer "contact_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "recurring", default: true
    t.datetime "end_date"
    t.integer "priority"
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "username"
    t.string "email"
    t.string "avatar"
    t.text "bio"
    t.bigint "requestor_id"
    t.bigint "requested_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password_digest"
    t.text "splash_image"
    t.index ["requested_id"], name: "index_users_on_requested_id"
    t.index ["requestor_id"], name: "index_users_on_requestor_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
end

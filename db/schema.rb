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

ActiveRecord::Schema.define(version: 20160715020919) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "assessments", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.date     "due_date"
    t.float    "weight"
    t.float    "grade"
    t.integer  "course_id"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.boolean  "important",       default: false
    t.string   "assessment_type"
  end

  add_index "assessments", ["course_id"], name: "index_assessments_on_course_id", using: :btree

  create_table "courses", force: :cascade do |t|
    t.string   "title"
    t.integer  "credit"
    t.string   "instructor"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "user_id"
    t.float    "grade"
    t.float    "desired_grade"
    t.string   "term"
  end

  add_index "courses", ["user_id"], name: "index_courses_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.string   "provider"
    t.string   "uid"
    t.string   "facebook_token"
    t.text     "facebook_raw_data"
    t.string   "profile_image"
    t.integer  "facebook_expires_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["uid", "provider"], name: "index_users_on_uid_and_provider", using: :btree

  add_foreign_key "assessments", "courses"
  add_foreign_key "courses", "users"
end

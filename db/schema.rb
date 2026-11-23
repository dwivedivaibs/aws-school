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

ActiveRecord::Schema.define(version: 2026_11_23_080000) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "achievement_images", force: :cascade do |t|
    t.bigint "achievement_id", null: false
    t.string "image"
    t.integer "position", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["achievement_id"], name: "index_achievement_images_on_achievement_id"
  end

  create_table "achievements", force: :cascade do |t|
    t.bigint "student_id"
    t.string "team_name"
    t.string "title", null: false
    t.string "category", null: false
    t.string "level"
    t.string "position"
    t.string "score"
    t.date "event_date"
    t.string "academic_session"
    t.text "description"
    t.string "certificate"
    t.string "event_photo"
    t.boolean "is_featured", default: false
    t.boolean "is_active", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["academic_session"], name: "index_achievements_on_academic_session"
    t.index ["category"], name: "index_achievements_on_category"
    t.index ["student_id"], name: "index_achievements_on_student_id"
  end

  create_table "active_admin_comments", force: :cascade do |t|
    t.string "namespace"
    t.text "body"
    t.string "resource_type"
    t.bigint "resource_id"
    t.string "author_type"
    t.bigint "author_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id"
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace"
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id"
  end

  create_table "admin_users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_admin_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true
  end

  create_table "contents", force: :cascade do |t|
    t.text "description"
    t.string "content_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "documents", force: :cascade do |t|
    t.string "name"
    t.string "file"
    t.boolean "is_active", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "gallery_images", force: :cascade do |t|
    t.string "section"
    t.string "image"
    t.boolean "is_active", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "gallery_videos", force: :cascade do |t|
    t.string "video"
    t.boolean "is_active", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "students", force: :cascade do |t|
    t.string "name", null: false
    t.string "admission_no"
    t.string "student_class"
    t.string "section"
    t.string "house"
    t.string "photo"
    t.boolean "is_alumni", default: false
    t.string "passing_year"
    t.text "bio"
    t.boolean "is_active", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["admission_no"], name: "index_students_on_admission_no"
    t.index ["name"], name: "index_students_on_name"
  end

  create_table "summer_homeworks", force: :cascade do |t|
    t.string "class_name"
    t.string "homework_doc"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tc_entries", force: :cascade do |t|
    t.string "tc_number"
    t.string "student_name"
    t.string "father_name"
    t.string "mother_name"
    t.string "nationality"
    t.boolean "sc_st_obc"
    t.datetime "dob"
    t.string "result"
    t.string "subjects"
    t.string "last_class"
    t.string "last_class_result"
    t.boolean "qualified_for_promotion"
    t.boolean "dues_paid"
    t.boolean "ncc_cadets"
    t.datetime "last_day_school"
    t.string "leaving_reason"
    t.string "total_meeting_attendance"
    t.string "total_attendance"
    t.string "general_conduct"
    t.string "category"
    t.datetime "certificate_issue_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "achievement_images", "achievements"
  add_foreign_key "achievements", "students"
end

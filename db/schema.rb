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

ActiveRecord::Schema.define(version: 20170118190518) do

  create_table "profiles", force: :cascade do |t|
    t.string   "uid"
    t.string   "name"
    t.string   "title"
    t.string   "current_position"
    t.text     "summary"
    t.text     "experience"
    t.text     "education"
    t.float    "score"
    t.string   "url"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.index ["current_position", "name"], name: "index_profiles_on_current_position_and_name"
    t.index ["name", "title", "current_position"], name: "index_profiles_on_name_and_title_and_current_position"
    t.index ["title", "current_position"], name: "index_profiles_on_title_and_current_position"
    t.index ["uid"], name: "index_profiles_on_uid", unique: true
  end

  create_table "skills", force: :cascade do |t|
    t.string   "name"
    t.integer  "profile_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name", "profile_id"], name: "index_skills_on_name_and_profile_id"
    t.index ["profile_id"], name: "index_skills_on_profile_id"
  end

end

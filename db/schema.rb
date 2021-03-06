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

ActiveRecord::Schema.define(version: 20170411005919) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "characters", force: :cascade do |t|
    t.string   "name"
    t.integer  "hit_points",  default: 0
    t.integer  "armor_class", default: 0
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "combats", force: :cascade do |t|
    t.json     "data"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.datetime "deleted_at"
    t.integer  "user_id"
    t.integer  "encounter_id"
    t.index ["deleted_at"], name: "index_combats_on_deleted_at", using: :btree
    t.index ["encounter_id"], name: "index_combats_on_encounter_id", using: :btree
    t.index ["user_id"], name: "index_combats_on_user_id", using: :btree
  end

  create_table "encounters", force: :cascade do |t|
    t.string   "name"
    t.integer  "challenge_rating",  default: 0
    t.integer  "experience_points", default: 0
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.integer  "user_id"
    t.index ["user_id"], name: "index_encounters_on_user_id", using: :btree
  end

  create_table "enemies", force: :cascade do |t|
    t.string   "name"
    t.integer  "hit_points",       default: 0
    t.integer  "armor_class",      default: 0
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.integer  "encounter_id"
    t.integer  "initiative_bonus", default: 0
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.boolean  "admin",                  default: false
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  add_foreign_key "combats", "encounters"
  add_foreign_key "combats", "users"
  add_foreign_key "encounters", "users"
end

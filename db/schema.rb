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

ActiveRecord::Schema.define(version: 20140317152329) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "answers", force: true do |t|
    t.integer  "player_id"
    t.integer  "challenge_id"
    t.string   "answer"
    t.datetime "updated_at"
    t.datetime "created_at"
    t.boolean  "is_correct"
  end

  add_index "answers", ["challenge_id"], name: "index_answers_on_challenge_id", using: :btree
  add_index "answers", ["player_id"], name: "index_answers_on_player_id", using: :btree

  create_table "challenges", force: true do |t|
    t.string   "name"
    t.datetime "updated_at"
    t.datetime "created_at"
  end

  create_table "flags", force: true do |t|
    t.integer  "challenge_id"
    t.integer  "point"
    t.datetime "updated_at"
    t.datetime "created_at"
    t.string   "flag"
  end

  add_index "flags", ["challenge_id"], name: "index_flags_on_challenge_id", using: :btree

  create_table "players", force: true do |t|
    t.integer  "team_id"
    t.string   "name"
    t.string   "email"
    t.string   "password_digest"
    t.datetime "updated_at"
    t.datetime "created_at"
  end

  add_index "players", ["team_id"], name: "index_players_on_team_id", using: :btree

  create_table "settings", force: true do |t|
    t.string   "var",                   null: false
    t.text     "value"
    t.integer  "thing_id"
    t.string   "thing_type", limit: 30
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "settings", ["thing_type", "thing_id", "var"], name: "index_settings_on_thing_type_and_thing_id_and_var", unique: true, using: :btree

  create_table "teams", force: true do |t|
    t.string   "name"
    t.string   "password_digest"
    t.datetime "updated_at"
    t.datetime "created_at"
    t.datetime "suspended_until"
  end

end

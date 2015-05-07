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

ActiveRecord::Schema.define(version: 20140423165637) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "adjustments", force: :cascade do |t|
    t.integer  "player_id"
    t.integer  "challenge_id"
    t.integer  "point"
    t.string   "reason"
    t.datetime "updated_at"
    t.datetime "created_at"
  end

  add_index "adjustments", ["challenge_id"], name: "index_adjustments_on_challenge_id", using: :btree
  add_index "adjustments", ["player_id"], name: "index_adjustments_on_player_id", using: :btree

  create_table "admins", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "admins", ["email"], name: "index_admins_on_email", unique: true, using: :btree
  add_index "admins", ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true, using: :btree

  create_table "answers", force: :cascade do |t|
    t.integer  "player_id"
    t.integer  "challenge_id"
    t.string   "answer"
    t.datetime "updated_at"
    t.datetime "created_at"
    t.boolean  "is_correct"
    t.integer  "flag_id"
    t.boolean  "is_answered"
  end

  add_index "answers", ["challenge_id"], name: "index_answers_on_challenge_id", using: :btree
  add_index "answers", ["flag_id"], name: "index_answers_on_flag_id", using: :btree
  add_index "answers", ["player_id"], name: "index_answers_on_player_id", using: :btree

  create_table "challenges", force: :cascade do |t|
    t.string   "name"
    t.datetime "updated_at"
    t.datetime "created_at"
    t.string   "genre"
    t.datetime "opened_at"
    t.text     "description"
  end

  create_table "flags", force: :cascade do |t|
    t.integer  "challenge_id"
    t.integer  "point"
    t.datetime "updated_at"
    t.datetime "created_at"
    t.string   "flag"
  end

  add_index "flags", ["challenge_id"], name: "index_flags_on_challenge_id", using: :btree

  create_table "players", force: :cascade do |t|
    t.integer  "team_id"
    t.string   "name"
    t.string   "email"
    t.datetime "updated_at"
    t.datetime "created_at"
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
  end

  add_index "players", ["confirmation_token"], name: "index_players_on_confirmation_token", unique: true, using: :btree
  add_index "players", ["email"], name: "index_players_on_email", unique: true, using: :btree
  add_index "players", ["reset_password_token"], name: "index_players_on_reset_password_token", unique: true, using: :btree
  add_index "players", ["team_id"], name: "index_players_on_team_id", using: :btree

  create_table "posts", force: :cascade do |t|
    t.string   "title"
    t.text     "body"
    t.string   "public_scope"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "settings", force: :cascade do |t|
    t.string   "var",                   null: false
    t.text     "value"
    t.integer  "thing_id"
    t.string   "thing_type", limit: 30
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "settings", ["thing_type", "thing_id", "var"], name: "index_settings_on_thing_type_and_thing_id_and_var", unique: true, using: :btree

  create_table "teams", force: :cascade do |t|
    t.string   "name"
    t.string   "password_digest"
    t.datetime "updated_at"
    t.datetime "created_at"
    t.datetime "suspended_until"
    t.string   "email"
  end

end

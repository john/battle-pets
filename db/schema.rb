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

ActiveRecord::Schema.define(version: 20170227174149) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "battles", force: :cascade do |t|
    t.integer  "contest_id"
    t.datetime "start_at"
    t.datetime "won_at"
    t.integer  "won_by"
    t.boolean  "upset"
    t.integer  "created_by"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["contest_id"], name: "index_battles_on_contest_id", using: :btree
    t.index ["created_by"], name: "index_battles_on_created_by", using: :btree
    t.index ["won_by"], name: "index_battles_on_won_by", using: :btree
  end

  create_table "contests", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.string   "algorithm"
    t.string   "winning_characteristic"
    t.integer  "created_by"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.index ["created_by"], name: "index_contests_on_created_by", using: :btree
    t.index ["name"], name: "index_contests_on_name", using: :btree
  end

  create_table "moves", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["name"], name: "index_moves_on_name", using: :btree
  end

  create_table "participants", force: :cascade do |t|
    t.integer  "battle_id"
    t.integer  "pet_id"
    t.integer  "created_by"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["battle_id"], name: "index_participants_on_battle_id", using: :btree
    t.index ["created_by"], name: "index_participants_on_created_by", using: :btree
    t.index ["pet_id"], name: "index_participants_on_pet_id", using: :btree
  end

  create_table "pets", force: :cascade do |t|
    t.string   "uuid"
    t.string   "name"
    t.integer  "strength"
    t.integer  "intelligence"
    t.integer  "speed"
    t.integer  "integrity"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["name"], name: "index_pets_on_name", using: :btree
    t.index ["uuid"], name: "index_pets_on_uuid", using: :btree
  end

  create_table "turns", force: :cascade do |t|
    t.integer  "battle_id"
    t.integer  "participant_id"
    t.integer  "move_id"
    t.integer  "user_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.index ["battle_id"], name: "index_turns_on_battle_id", using: :btree
    t.index ["move_id"], name: "index_turns_on_move_id", using: :btree
    t.index ["participant_id"], name: "index_turns_on_participant_id", using: :btree
    t.index ["user_id"], name: "index_turns_on_user_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",                                   null: false
    t.datetime "updated_at",                                   null: false
    t.string   "email",                           default: "", null: false
    t.string   "encrypted_password",              default: "", null: false
    t.string   "authentication_token",            default: "", null: false
    t.datetime "authentication_token_created_at"
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                   default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  add_foreign_key "battles", "contests"
  add_foreign_key "participants", "battles"
  add_foreign_key "participants", "pets"
  add_foreign_key "turns", "battles"
  add_foreign_key "turns", "moves"
  add_foreign_key "turns", "participants"
  add_foreign_key "turns", "users"
end

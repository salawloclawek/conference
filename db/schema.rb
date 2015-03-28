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

ActiveRecord::Schema.define(version: 20150326212854) do

  create_table "key_maps", force: :cascade do |t|
    t.integer "phone_id"
    t.integer "digit"
    t.string  "name"
  end

  create_table "meets", force: :cascade do |t|
    t.string "name"
    t.string "phone_number"
    t.string "asterisk_user_profile_pre"
    t.string "sip_number"
    t.string "web_pin"
    t.string "token"
  end

  create_table "phones", force: :cascade do |t|
    t.integer "meet_id"
    t.string  "phone_number"
    t.string  "name"
    t.boolean "auto_join"
    t.boolean "admin"
  end

  add_index "phones", ["phone_number"], name: "index_phones_on_phone_number", unique: true

end

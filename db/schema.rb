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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20111201024429) do

  create_table "as_labels", :force => true do |t|
    t.string   "name"
    t.text     "comment"
    t.string   "label_format"
    t.text     "possible_values"
    t.boolean  "is_required"
    t.integer  "position"
    t.text     "default_value"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "as_note_id"
    t.boolean  "invisible",       :default => false
    t.boolean  "default_sort",    :default => false
  end

  create_table "as_notes", :force => true do |t|
    t.string   "name"
    t.text     "comment"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "public"
  end

  create_table "as_values", :force => true do |t|
    t.text     "value"
    t.integer  "numero"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "as_label_id"
  end

  create_table "friendships", :force => true do |t|
    t.integer  "user_id"
    t.integer  "friend_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ownerships", :force => true do |t|
    t.integer  "as_note_id"
    t.integer  "user_id"
    t.integer  "position"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "email"
    t.string   "password_hash"
    t.string   "password_salt"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "nick_name"
  end

end

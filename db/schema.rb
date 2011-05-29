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

ActiveRecord::Schema.define(:version => 20110529055513) do

  create_table "as_labels", :force => true do |t|
    t.string   "name"
    t.text     "comment"
    t.string   "label_format"
    t.text     "possible_values"
    t.integer  "min_length"
    t.integer  "max_length"
    t.string   "regexp"
    t.boolean  "is_required"
    t.boolean  "is_filter"
    t.integer  "position"
    t.boolean  "searchable"
    t.text     "default_value"
    t.boolean  "editable"
    t.boolean  "visible"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "as_notes", :force => true do |t|
    t.string   "name"
    t.text     "comment"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "as_values", :force => true do |t|
    t.text     "value"
    t.integer  "numero"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end

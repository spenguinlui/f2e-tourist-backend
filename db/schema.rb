# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_12_30_041825) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "local_items", force: :cascade do |t|
    t.string "ptx_data_id", null: false
    t.string "ptx_data_type"
    t.text "feature"
    t.integer "search_count", default: 0
    t.integer "enter_count", default: 0
    t.integer "favorite_count", default: 0
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "themes", force: :cascade do |t|
    t.string "theme_name", null: false
    t.string "theme_tags", array: true
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

end

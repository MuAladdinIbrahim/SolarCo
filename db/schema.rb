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

ActiveRecord::Schema.define(version: 2020_05_22_134519) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "calculations", force: :cascade do |t|
    t.bigint "system_id"
    t.integer "panels_no", default: 0
    t.integer "panel_rating_power", default: 0
    t.string "panel_type"
    t.integer "battery_rating_Ah", default: 0
    t.integer "patterns_no", default: 0
    t.integer "inverter_rating_power", default: 0
    t.integer "inverters_no", default: 0
    t.string "inverter_type"
    t.integer "cc_rating_power", default: 0
    t.integer "cc_no", default: 0
    t.string "cc_type"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["system_id"], name: "index_calculations_on_system_id"
  end

  create_table "systems", force: :cascade do |t|
    t.string "type"
    t.integer "latitude", default: 0
    t.integer "longitude", default: 0
    t.integer "electricity_bill", default: 0
    t.string "city"
    t.bigint "user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_systems_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password"
    t.boolean "is_contractor", default: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

end

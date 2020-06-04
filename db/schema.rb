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

ActiveRecord::Schema.define(version: 2020_06_03_170514) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: :cascade do |t|
    t.string "namespace"
    t.text "body"
    t.string "resource_type"
    t.bigint "resource_id"
    t.string "author_type"
    t.bigint "author_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id"
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace"
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id"
  end

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "admin_users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_admin_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true
  end

  create_table "calculations", force: :cascade do |t|
    t.integer "system_circuits", default: 1
    t.integer "panels_num", default: 1
    t.integer "panel_watt", default: 250
    t.integer "battery_Ah", default: 200
    t.integer "batteries_num", default: 1
    t.integer "inverter_watt", default: 0
    t.integer "mppt_amp", default: 0
    t.bigint "system_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["system_id"], name: "index_calculations_on_system_id"
  end

  create_table "contractors", force: :cascade do |t|
    t.string "address"
    t.string "mobileNumber"
    t.string "website"
    t.string "fax"
    t.boolean "is_verified"
    t.integer "rate", default: 0
    t.string "provider", default: "email", null: false
    t.string "uid", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.boolean "allow_password_change", default: false
    t.datetime "remember_created_at"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.string "name"
    t.string "image"
    t.string "email"
    t.json "tokens"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "username", default: "username", null: false
    t.index ["confirmation_token"], name: "index_contractors_on_confirmation_token", unique: true
    t.index ["email"], name: "index_contractors_on_email", unique: true
    t.index ["reset_password_token"], name: "index_contractors_on_reset_password_token", unique: true
    t.index ["uid", "provider"], name: "index_contractors_on_uid_and_provider", unique: true
  end

  create_table "offer_rates", force: :cascade do |t|
    t.decimal "rate"
    t.bigint "user_id", null: false
    t.bigint "offer_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["offer_id"], name: "index_offer_rates_on_offer_id"
    t.index ["user_id"], name: "index_offer_rates_on_user_id"
  end

  create_table "offer_reviews", force: :cascade do |t|
    t.text "review"
    t.bigint "user_id", null: false
    t.bigint "offer_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["offer_id"], name: "index_offer_reviews_on_offer_id"
    t.index ["user_id"], name: "index_offer_reviews_on_user_id"
  end

  create_table "offers", force: :cascade do |t|
    t.string "proposal"
    t.integer "price"
    t.integer "status", default: 1
    t.bigint "contractor_id"
    t.bigint "post_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["contractor_id"], name: "index_offers_on_contractor_id"
    t.index ["post_id"], name: "index_offers_on_post_id"
  end

  create_table "posts", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "title", null: false
    t.text "description", null: false
    t.bigint "system_id", null: false
    t.index ["system_id"], name: "index_posts_on_system_id"
    t.index ["user_id"], name: "index_posts_on_user_id"
  end

  create_table "systems", force: :cascade do |t|
    t.decimal "latitude", precision: 17, scale: 14, default: "0.0"
    t.decimal "longitude", precision: 17, scale: 14, default: "0.0"
    t.integer "consumption", default: 0
    t.string "city", null: false
    t.string "country", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_systems_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "provider", default: "email", null: false
    t.string "uid", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.boolean "allow_password_change", default: false
    t.datetime "remember_created_at"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.string "name"
    t.string "image"
    t.string "email"
    t.json "tokens"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "type", default: "Client", null: false
    t.string "username", default: "username", null: false
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["uid", "provider"], name: "index_users_on_uid_and_provider", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "calculations", "systems"
  add_foreign_key "offer_rates", "offers"
  add_foreign_key "offer_rates", "users"
  add_foreign_key "offer_reviews", "offers"
  add_foreign_key "offer_reviews", "users"
  add_foreign_key "offers", "contractors"
  add_foreign_key "offers", "posts"
  add_foreign_key "posts", "systems"
  add_foreign_key "posts", "users"
  add_foreign_key "systems", "users"
end

# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2018_06_16_172609) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "packages", force: :cascade do |t|
    t.string "name"
    t.integer "price"
    t.text "description"
    t.integer "available_per_night"
    t.bigint "venue_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "photo"
    t.index ["venue_id"], name: "index_packages_on_venue_id"
  end

  create_table "squadchosenvenues", force: :cascade do |t|
    t.bigint "squad_id"
    t.bigint "venue_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["squad_id"], name: "index_squadchosenvenues_on_squad_id"
    t.index ["venue_id"], name: "index_squadchosenvenues_on_venue_id"
  end

  create_table "squadmembers", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "squad_id"
    t.bigint "squadchosenvenue_id"
    t.boolean "will_be_present"
    t.integer "contribution"
    t.integer "swag_points"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["squad_id"], name: "index_squadmembers_on_squad_id"
    t.index ["squadchosenvenue_id"], name: "index_squadmembers_on_squadchosenvenue_id"
    t.index ["user_id"], name: "index_squadmembers_on_user_id"
  end

  create_table "squads", force: :cascade do |t|
    t.datetime "night_out"
    t.bigint "user_id"
    t.bigint "package_id"
    t.boolean "confirmed"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["package_id"], name: "index_squads_on_package_id"
    t.index ["user_id"], name: "index_squads_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "photo"
    t.string "first_name"
    t.string "last_name"
    t.string "phone_number"
    t.string "address"
    t.string "provider"
    t.string "uid"
    t.string "facebook_picture_url"
    t.string "token"
    t.datetime "token_expiry"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "venues", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.float "longitude"
    t.float "latitude"
    t.string "address"
    t.string "music_genre"
    t.string "instagram_handle"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "capacity"
    t.integer "pricing"
    t.string "photo"
    t.float "rating"
    t.integer "review_count"
  end

  add_foreign_key "packages", "venues"
  add_foreign_key "squadchosenvenues", "squads"
  add_foreign_key "squadchosenvenues", "venues"
  add_foreign_key "squadmembers", "squadchosenvenues"
  add_foreign_key "squadmembers", "squads"
  add_foreign_key "squadmembers", "users"
  add_foreign_key "squads", "users"
end

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

ActiveRecord::Schema.define(version: 20170607010304) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "identities", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "uid"
    t.string   "provider"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_identities_on_user_id", using: :btree
  end

  create_table "properties", force: :cascade do |t|
    t.string   "name"
    t.integer  "number_of_guests"
    t.integer  "number_of_beds"
    t.integer  "number_of_rooms"
    t.text     "description"
    t.decimal  "price_per_night"
    t.string   "address"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.float    "lat"
    t.float    "long"
    t.string   "image_url"
    t.string   "check_in_time"
    t.string   "check_out_time"
    t.integer  "status",              default: 0
    t.integer  "owner_id"
    t.integer  "room_type_id"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.integer  "number_of_bathrooms"
    t.index ["owner_id"], name: "index_properties_on_owner_id", using: :btree
    t.index ["room_type_id"], name: "index_properties_on_room_type_id", using: :btree
  end

  create_table "property_availabilities", force: :cascade do |t|
    t.date     "date"
    t.boolean  "reserved?",   default: false
    t.integer  "property_id"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.index ["property_id"], name: "index_property_availabilities_on_property_id", using: :btree
  end

  create_table "property_conversations", force: :cascade do |t|
    t.integer "user_id"
    t.integer "property_id"
    t.integer "cid"
    t.index ["property_id"], name: "index_property_conversations_on_property_id", using: :btree
    t.index ["user_id"], name: "index_property_conversations_on_user_id", using: :btree
  end

  create_table "reservations", force: :cascade do |t|
    t.decimal  "total_price"
    t.date     "start_date"
    t.date     "end_date"
    t.integer  "number_of_guests"
    t.integer  "property_id"
    t.integer  "renter_id"
    t.integer  "status",           default: 0
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.index ["property_id"], name: "index_reservations_on_property_id", using: :btree
    t.index ["renter_id"], name: "index_reservations_on_renter_id", using: :btree
  end

  create_table "reviews", force: :cascade do |t|
    t.integer  "property_id"
    t.integer  "user_id"
    t.integer  "rating"
    t.text     "comment"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["property_id"], name: "index_reviews_on_property_id", using: :btree
    t.index ["user_id"], name: "index_reviews_on_user_id", using: :btree
  end

  create_table "room_types", force: :cascade do |t|
    t.integer  "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "image_url"
    t.string   "email",                   default: "",    null: false
    t.string   "phone_number"
    t.text     "description"
    t.string   "hometown"
    t.integer  "role",                    default: 0
    t.boolean  "active?",                 default: true
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
    t.string   "encrypted_password",      default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",           default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.string   "google_uid"
    t.string   "google_oauth_token"
    t.datetime "google_oauth_expires_at"
    t.string   "facebook_uid"
    t.string   "facebook_token"
    t.string   "authy_id"
    t.datetime "last_sign_in_with_authy"
    t.boolean  "authy_enabled",           default: false
    t.index ["authy_id"], name: "index_users_on_authy_id", using: :btree
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  add_foreign_key "identities", "users"
  add_foreign_key "properties", "room_types"
  add_foreign_key "properties", "users", column: "owner_id"
  add_foreign_key "property_availabilities", "properties"
  add_foreign_key "property_conversations", "properties"
  add_foreign_key "property_conversations", "users"
  add_foreign_key "reservations", "properties"
  add_foreign_key "reservations", "users", column: "renter_id"
  add_foreign_key "reviews", "properties"
  add_foreign_key "reviews", "users"
end

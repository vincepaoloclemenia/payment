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

ActiveRecord::Schema.define(version: 20210319050524) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "reservation_contacts", force: :cascade do |t|
    t.string "number"
    t.bigint "reservation_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["reservation_id"], name: "index_reservation_contacts_on_reservation_id"
  end

  create_table "reservations", force: :cascade do |t|
    t.integer "nights"
    t.datetime "start_date"
    t.datetime "end_date"
    t.decimal "total_paid_amount_accurate", default: "0.0"
    t.bigint "user_id"
    t.string "status"
    t.boolean "active"
    t.string "host_currency"
    t.decimal "expected_pay_amount", default: "0.0"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "number_of_children"
    t.integer "number_of_adults"
    t.integer "number_of_infants"
    t.decimal "listing_security_price_accurate", default: "0.0"
    t.index ["user_id"], name: "index_reservations_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end

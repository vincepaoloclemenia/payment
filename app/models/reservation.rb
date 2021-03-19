# create_table "reservations", force: :cascade do |t|
#   t.integer "nights"
#   t.datetime "start_date"
#   t.datetime "end_date"
#   t.decimal "total_paid_amount_accurate", default: "0.0"
#   t.bigint "user_id"
#   t.string "status"
#   t.boolean "active"
#   t.string "host_currency"
#   t.decimal "expected_pay_amount", default: "0.0"
#   t.datetime "created_at", null: false
#   t.datetime "updated_at", null: false
#   t.integer "number_of_children"
#   t.integer "number_of_adults"
#   t.integer "number_of_infants"
#   t.decimal "listing_security_price_accurate", default: "0.0"
#   t.index ["user_id"], name: "index_reservations_on_user_id"
# end
class Reservation < ApplicationRecord
  belongs_to :user
  has_many :reservation_contacts
  accepts_nested_attributes_for :reservation_contacts

  validates_presence_of :start_date, :end_date, :nights, :total_paid_amount_accurate, :status, :host_currency,
                        :expected_pay_amount, :number_of_children, :number_of_adults, :number_of_infants,
                        :listing_security_price_accurate

                        
end

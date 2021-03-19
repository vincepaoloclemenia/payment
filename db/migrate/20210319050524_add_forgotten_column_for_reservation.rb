class AddForgottenColumnForReservation < ActiveRecord::Migration[5.1]
  def change
    rename_column :reservations, :stay_in_days, :nights
    rename_column :reservations, :total_paid, :total_paid_amount_accurate
    add_column :reservations, :listing_security_price_accurate, :decimal, default: 0.0
  end
end

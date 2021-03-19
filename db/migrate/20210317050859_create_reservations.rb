class CreateReservations < ActiveRecord::Migration[5.1]
  def change
    create_table :reservations do |t|
      t.integer :stay_in_days
      t.datetime :start_date
      t.datetime :end_date
      t.decimal :total_paid, default: 0.0
      t.belongs_to :user
      t.string :status
      t.boolean :active
      t.string :host_currency
      t.integer :number_of_guests
      t.decimal :expected_pay_amount, default: 0.0

      t.timestamps
    end
  end
end

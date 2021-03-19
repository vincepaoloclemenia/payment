class ChangeAndAddColumnsForReservation < ActiveRecord::Migration[5.1]
  def change
      remove_column :reservations, :number_of_guests
      add_column :reservations, :number_of_children, :integer
      add_column :reservations, :number_of_adults, :integer
      add_column :reservations, :number_of_infants, :integer
  end
end

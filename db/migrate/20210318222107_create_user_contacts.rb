class CreateUserContacts < ActiveRecord::Migration[5.1]
  def change
    create_table :reservation_contacts do |t|
      t.string :number
      t.belongs_to :reservation
      t.timestamps
    end
  end
end

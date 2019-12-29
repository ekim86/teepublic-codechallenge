class CreateReservations < ActiveRecord::Migration[5.2]
  def change
    create_table :reservations do |t|
      t.integer :user_id
      t.integer :restaurant_id
      t.string :month
      t.integer :day
      t.integer :year
      t.time :time

      t.timestamps
    end
  end
end

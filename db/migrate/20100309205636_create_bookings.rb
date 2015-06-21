class CreateBookings < ActiveRecord::Migration
  def self.up
    create_table :bookings do |t|
        t.integer :customer_id
		t.integer :room_id

		t.datetime :start_time
		t.datetime :end_time

		t.string :reserver
		t.string :telephone
     	t.string :description

		t.integer :week
		     
		t.timestamps
	 end
  end

  def self.down
    drop_table :bookings
  end
end

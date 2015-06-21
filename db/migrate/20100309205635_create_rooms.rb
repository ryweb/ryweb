class CreateRooms < ActiveRecord::Migration
  def self.up
    create_table :rooms do |t|
      t.column :customer_id, :integer
      t.column :name, :string
      t.column :description, :string
      
		t.timestamps
	 end
  end

  def self.down
    drop_table :rooms
  end
end

class CreateLocations < ActiveRecord::Migration
  def self.up
    create_table :locations do |t|
      t.column :name, :string
      t.column :description, :string
      t.column :address, :string
      t.column :owner, :integer

      t.timestamps

    end
  end

  def self.down
    drop_table :locations
  end
end

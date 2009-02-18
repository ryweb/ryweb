class AlterLocations < ActiveRecord::Migration
  def self.up
    add_column(:locations, :customer_id, :integer)    
  end

  def self.down
    remove_column(:locations, :customer_id)    
  end
end

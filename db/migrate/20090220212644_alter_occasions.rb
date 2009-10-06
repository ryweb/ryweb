class AlterOccasions < ActiveRecord::Migration
  def self.up
    add_column(:occasions, :customer_id, :integer)    
  end

  def self.down
    remove_column(:occasions, :customer_id)    
  end
end

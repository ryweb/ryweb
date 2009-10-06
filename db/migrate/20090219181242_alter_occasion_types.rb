class AlterOccasionTypes < ActiveRecord::Migration
  def self.up
    add_column(:occasion_types, :customer_id, :integer)    
  end

  def self.down
    remove_column(:occasion_types, :customer_id)    
  end
end

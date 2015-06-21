class AlterOccasions2 < ActiveRecord::Migration
  def self.up
    change_column(:occasions, :state, :integer, :default => 10)
  end

  def self.down
    change_column(:occasions, :state, :integer, :default => nil)
  end
end

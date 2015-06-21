class AlterOccasions4 < ActiveRecord::Migration
  def self.up
    change_column(:occasions, :repeat, :integer, :default => 0)
  end

  def self.down
    change_column(:occasions, :repeat, :integer, :default => nil)
  end
end

class AlterOccasionTypes2 < ActiveRecord::Migration
  def self.up
    change_column(:occasion_types, :visibility, :integer, :default => 10)
  end

  def self.down
    change_column(:occasion_types, :visibility, :integer, :default => nil)
  end
end

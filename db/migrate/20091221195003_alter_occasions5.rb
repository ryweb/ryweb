class AlterOccasions5 < ActiveRecord::Migration
  def self.up
    add_column(:occasions, :inform_changes, :boolean, :default => false)
  end

  def self.down
     remove_column(:occasions, :inform_changes)
  end
end

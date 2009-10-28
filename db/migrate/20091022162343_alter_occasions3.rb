class AlterOccasions3 < ActiveRecord::Migration
  def self.up
    add_column(:occasions, :repeat, :integer)
    add_column(:occasions, :repeat_until, :date)
  end

  def self.down
    remove_column(:occasions, :repeat)
    remove_column(:occasions, :repeat_until)
  end
end

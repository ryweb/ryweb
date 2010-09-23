class AddNetRadioToOccasion < ActiveRecord::Migration
  def self.up
    add_column :occasions, :net_radio, :integer
  end

  def self.down
    remove_column :occasions, :net_radio
  end
end

class ChangeCustomer < ActiveRecord::Migration
  def self.up
    # This is for defining a mission target area like 'Etelä-Pohjanmaa'
    add_column :customers, :target_area, :integer
    # This is for defining a power base of campground, e.g. 'Hankasalmi'
    add_column :customers, :power_base, :integer
    change_column_default(:customers, :language, 'fi')
  end

  def self.down
    remove_column :customers, :power_base
    remove_column :customers, :target_area
    change_column_default(:customers, :language, nil)
  end
end

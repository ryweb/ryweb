class ChangeCustomerDefaults < ActiveRecord::Migration
  def self.up
    change_column_default(:customers, :target_area, '')
    change_column_default(:customers, :power_base, '')
    change_column_default(:customers, :logo, '')
  end

  def self.down
    change_column_default(:customers, :target_area, nil)
    change_column_default(:customers, :power_base, nil)
    change_column_default(:customers, :logo, nil)
  end
end

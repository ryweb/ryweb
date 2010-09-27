class ChangeZipCode < ActiveRecord::Migration
  def self.up
    change_column :customers, :zip_code, :string
  end

  def self.down
    change_column :customers, :zip_code, :integer
  end
end

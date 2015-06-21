class AddLogoToCustomer < ActiveRecord::Migration
  def self.up
    add_column :customers, :logo, :string
  end

  def self.down
    remove_column :customers, :logo
  end
end

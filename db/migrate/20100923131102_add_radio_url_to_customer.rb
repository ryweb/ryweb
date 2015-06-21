class AddRadioUrlToCustomer < ActiveRecord::Migration
  def self.up
    add_column :customers, :radio_url, :string
  end

  def self.down
    remove_column :customers, :radio_url
  end
end

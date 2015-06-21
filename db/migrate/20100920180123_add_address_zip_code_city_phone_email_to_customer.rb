class AddAddressZipCodeCityPhoneEmailToCustomer < ActiveRecord::Migration
  def self.up
    add_column :customers, :address, :string
    add_column :customers, :zip_code, :integer
    add_column :customers, :city, :string
    add_column :customers, :phone, :string
    add_column :customers, :email, :string
  end

  def self.down
    remove_column :customers, :email
    remove_column :customers, :phone
    remove_column :customers, :city
    remove_column :customers, :zip_code
    remove_column :customers, :address
  end
end

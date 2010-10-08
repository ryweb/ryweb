require 'declarative_authorization/maintenance'

class ChangeCustomerDefaults < ActiveRecord::Migration
  def self.up
    Authorization::Maintenance::without_access_control do
    customers = Customer.find(:all)

    customers.each do |row|
      c = Customer.find(row)
      c.logo = '' if c.logo.nil?            
      c.radio_url = '' if c.radio_url.nil?
      c.address = '' if c.address.nil?
      c.zip_code = '' if c.zip_code.nil?
      c.city = '' if c.city.nil?
      c.phone = '' if c.phone.nil?
      c.email = '' if c.email.nil?
      c.save
      if c.save
        puts "Yhdistyksen (#{c.title}) oletusarvot päivitettiin onnistuneesti"
      else
        puts "Yhdistyksen oletusarvojen päivitys epäonnistui"
        puts new_user.errors.full_messages
      end
    end
  end
  end

  def self.down
  end
end

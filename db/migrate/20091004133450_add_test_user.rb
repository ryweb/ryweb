class AddTestUser < ActiveRecord::Migration
  def self.up
    new_customer = Customer.new
    new_customer.name = "testi"

    if new_customer.save
      puts "Yhdistys (testi) lisättiin onnistuneesti"
    else
      puts "Yhdistyksen lisäys epäonnistui"
    end

    new_user = User.new
    new_user.login = "admin"
    new_user.password = "admin123"
    new_user.password_confirmation = "admin123"
    new_user.email = "admin@admin.com"
    new_user.name = "Admin"
    new_user.user_level = "10"

    if new_user.save
      puts "Käyttäjä (admin) lisättiin onnistuneesti"
    else
      puts "Käyttäjän lisäys epäonnistui"
      puts new_user.errors.full_messages
    end

  end

  def self.down
  end
end

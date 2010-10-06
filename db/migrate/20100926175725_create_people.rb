class CreatePeople < ActiveRecord::Migration
  def self.up
    create_table :people do |t|
      # basic information
      t.string :first_name
      t.string :surname
      t.string :address
      t.integer :postcode
      t.string :city
      t.string :phone
      t.string :email, :limit => 100
      t.string :social_security_number

      # membership
      t.string :membership_status
      t.integer :membership_year
      
      # speakers
      t.integer :invitation_year
      t.string :bank_account
      t.string :tax_rate

      t.integer :customer_id

      t.timestamps
    end
  end

  def self.down
    drop_table :people
  end
end

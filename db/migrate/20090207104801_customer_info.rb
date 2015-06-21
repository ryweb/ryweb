class CustomerInfo < ActiveRecord::Migration
  def self.up
    add_column(:customers, :title, :string)
  end

  def self.down
    remove_column(:customers, :title)
  end
end

class CreateCustomers < ActiveRecord::Migration
  def self.up
    create_table :customers do |t|
      t.column :name, :string
      t.timestamps
    end
  end

  def self.down
    drop_table :customers
  end
end

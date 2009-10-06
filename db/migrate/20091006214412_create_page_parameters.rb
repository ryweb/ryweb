class CreatePageParameters < ActiveRecord::Migration
  def self.up
    create_table :page_parameters do |t|
      t.column :page_id, :integer
      t.column :name, :string
      t.column :value, :string
      t.column :customer_id, :integer
      t.timestamps
    end
  end

  def self.down
    drop_table :page_parameters
  end
end

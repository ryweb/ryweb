class CreateOccasions < ActiveRecord::Migration
  def self.up
    create_table :occasions do |t|
      t.column :name,:string
      t.column :start_time, :datetime
      t.column :internal_info, :string
      t.column :public_info, :string
      t.column :state, :integer      
      t.column :occasion_type_id, :integer
      t.column :location_id, :integer
      t.timestamps
    end
  end

  def self.down
    drop_table :occasions
  end
end
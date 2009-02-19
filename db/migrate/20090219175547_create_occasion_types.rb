class CreateOccasionTypes < ActiveRecord::Migration
  def self.up
    create_table :occasion_types do |t|
      t.column :name, :string
      t.column :visibility, :integer
      t.timestamps
    end
  end

  def self.down
    drop_table :occasion_types
  end
end

class CreateStyles < ActiveRecord::Migration
  def self.up
    create_table :styles do |t|
      t.column :filename,     :string
      t.column :content_type, :string
      t.column :size,         :integer
      t.column :created_at,   :datetime
      t.column :customer_id,  :integer

      t.timestamps

    end
  end

  def self.down
    drop_table :styles
  end
end

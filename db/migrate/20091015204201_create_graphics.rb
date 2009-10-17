class CreateGraphics < ActiveRecord::Migration
  def self.up
    create_table :graphics do |t|
      t.column :filename,     :string
      t.column :content_type, :string
      t.column :size,         :integer
      t.column :width,        :integer
      t.column :height,       :integer
      t.column :parent_id,    :integer
      t.column :thumbnail,    :string
      t.column :created_at,   :datetime
      t.column :customer_id,  :integer

      t.timestamps

    end
  end

  def self.down
    drop_table :graphics
  end
end

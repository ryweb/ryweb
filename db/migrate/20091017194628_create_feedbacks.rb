class CreateFeedbacks < ActiveRecord::Migration
  def self.up
    create_table :feedbacks do |t|
      t.column :type,         :integer
      t.column :message,      :string
      t.column :user_id,      :integer
      t.column :customer_id,  :integer
      t.column :controller,   :string
      t.column  :action,      :string

      t.timestamps

    end
  end

  def self.down
    drop_table :feedbacks
  end
end

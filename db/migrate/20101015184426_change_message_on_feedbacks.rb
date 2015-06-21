class ChangeMessageOnFeedbacks < ActiveRecord::Migration
  def self.up
    change_column :feedbacks, :message, :text
  end

  def self.down
    change_column :feedbacks, :message, :string
  end
end

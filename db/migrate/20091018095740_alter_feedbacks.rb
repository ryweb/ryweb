class AlterFeedbacks < ActiveRecord::Migration
  def self.up
    rename_column(:feedbacks, :type, :category)
  end

  def self.down
    rename_column(:feedbacks, :category, :type)
  end
end

class AddSubjectToOccasion < ActiveRecord::Migration
  def self.up
    add_column :occasions, :subject, :string
  end

  def self.down
    remove_column :occasions, :subject
  end
end

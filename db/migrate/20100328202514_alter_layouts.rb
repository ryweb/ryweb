class AlterLayouts < ActiveRecord::Migration
  def self.up
    change_column :layouts, :content, :text
  end

  def self.down
    change_column :layouts, :content, :string
  end
end

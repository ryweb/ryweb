class AddMenuOrderToPageVersion < ActiveRecord::Migration
  def self.up
    add_column :page_versions, :menu_order, :integer
  end

  def self.down
    remove_column :page_versions, :menu_order
  end
end

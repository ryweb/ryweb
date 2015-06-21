class AddMenuOrderToPage < ActiveRecord::Migration
  def self.up
    add_column :pages, :menu_order, :integer
  end

  def self.down
    remove_column :pages, :menu_order
  end
end

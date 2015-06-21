class AlterPages < ActiveRecord::Migration
  def self.up
    change_column :pages, :content, :text
  end

  def self.down
    change_column :pages, :content, :string
  end
end

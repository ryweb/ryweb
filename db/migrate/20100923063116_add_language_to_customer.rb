class AddLanguageToCustomer < ActiveRecord::Migration
  def self.up
    add_column :customers, :language, :string, :default => 'fi'
  end

  def self.down
    remove_column :customers, :language
  end
end

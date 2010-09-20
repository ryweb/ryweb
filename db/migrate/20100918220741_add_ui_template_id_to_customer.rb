class AddUiTemplateIdToCustomer < ActiveRecord::Migration
  def self.up
    add_column :customers, :ui_template_id, :integer
  end

  def self.down
    remove_column :customers, :ui_template_id
  end
end

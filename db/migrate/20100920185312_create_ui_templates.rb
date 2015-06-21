class CreateUiTemplates < ActiveRecord::Migration
  def self.up
    create_table :ui_templates do |t|
      t.string :name
      t.text :content

      t.timestamps
    end
  end

  def self.down
    drop_table :ui_templates
  end
end

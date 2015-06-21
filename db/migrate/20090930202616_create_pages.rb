class CreatePages < ActiveRecord::Migration
  def self.up
    create_table :pages do |t|
      t.string :title
      t.string :content
      t.string :name
      t.integer :state
      t.integer :public
      t.integer :layout_id
      t.integer :author_id
      t.integer :page_type
      t.integer :customer_id
      t.timestamps
    end
  end

  def self.down
    drop_table :pages
  end
end

class AlterStyles < ActiveRecord::Migration
  def self.up
      add_column(:styles, :width, :integer)
      add_column(:styles, :height, :integer)
      add_column(:styles, :parent_id, :integer)
      add_column(:styles, :thumbnail, :integer)
  end

  def self.down
    remove_column(:styles, :width)
    remove_column(:styles, :height)
    remove_column(:styles, :parent_id)
    remove_column(:styles, :thumbnail)
  end
end

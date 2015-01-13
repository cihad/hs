class RemovePositionFromNodeImages < ActiveRecord::Migration
  def change
    remove_column :node_images, :position, :integer
  end
end

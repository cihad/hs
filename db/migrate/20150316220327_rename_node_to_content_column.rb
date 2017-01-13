class RenameNodeToContentColumn < ActiveRecord::Migration
  def change
    rename_table :node_images, :content_images
    rename_column :content_images, :node_id, :content_id
  end

end

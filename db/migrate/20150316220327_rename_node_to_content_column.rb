class RenameNodeToContentColumn < ActiveRecord::Migration
  def change
    rename_table :node_images, :content_images
    rename_column :content_images, :node_id, :content_id

    reversible do |dir|
      dir.up do
        puts "running..."
        node_ids = ContentImage.all.map(&:content_id)
        node_ids.each do |node_id|
          content_id = Node.find(node_id).content_id
          content_image = ContentImage.find_by content_id: node_id
          content_image.update content_id: content_id
        end
        say "all 'content_id's refilled by real node_id equivalent to <content object> in content_images table"
      end
    end
  end

end

class RenameNodeToContentColumn < ActiveRecord::Migration
  def change
    rename_table :node_images, :content_images
    rename_column :content_images, :node_id, :content_id

    reversible do |dir|
      dir.up do
        puts "running..."
        ContentImage.all.each do |ci|
          ci.content_id = Node.find(ci.content_id).content_id
          ci.save
        end
        say "all 'content_id's refilled by real node_id equivalent to <content object> in content_images table"
      end

      dir.down do
        class_name = Object.const_defined?("NodeImage") ? "NodeImage" : "ContentImage"
        class_name.constantize.all.each do |ni|
          ni.node_id = Node.find_by(content_id: ni.node_id).id
          ni.save
        end
        say "all 'node_id's refilled by real content_id equivalent to <node object> in node_images table"
      end
    end
  end

end

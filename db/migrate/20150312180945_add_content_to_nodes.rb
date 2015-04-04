class AddContentToNodes < ActiveRecord::Migration
  def change
    add_column :nodes, :content_id, :integer
    add_column :nodes, :content_type, :string
    add_index :nodes, [:content_id, :content_type], unique: true

    reversible do |dir|
      dir.up do
        Node.all.each do |node|
          unless node.content
            content = Content.create do |content|
              content.title = node.title
              content.body = node.body
            end

            node.content = content
            node.save
          end
        end
      end

      dir.down do
        if Object.const_defined? "Content"
          Content.delete_all
        end
      end
    end
  end
end

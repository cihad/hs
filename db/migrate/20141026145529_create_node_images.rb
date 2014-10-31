class CreateNodeImages < ActiveRecord::Migration
  def change
    create_table :node_images do |t|
      t.references :node
      t.references :image, index: true
      t.integer :position, default: 0

      t.timestamps null: false
    end
    add_index :node_images, [:node_id, :position]
  end
end

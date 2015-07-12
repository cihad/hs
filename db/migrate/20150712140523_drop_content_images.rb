class DropContentImages < ActiveRecord::Migration
  def change
    drop_table :content_images
  end
end

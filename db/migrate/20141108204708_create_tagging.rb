class CreateTagging < ActiveRecord::Migration
  def change
    create_table :taggings do |t|
      t.integer :taggable_id
      t.string :taggable_type
      t.integer :tag_id
      t.index [:taggable_id, :taggable_type, :tag_id], unique: true
    end
  end
end

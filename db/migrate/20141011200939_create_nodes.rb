class CreateNodes < ActiveRecord::Migration
  def change
    create_table :nodes do |t|
      t.string :title
      t.text :tldr
      t.text :body

      t.timestamps null: false
    end
  end
end

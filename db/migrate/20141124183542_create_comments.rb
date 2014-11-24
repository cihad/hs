class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.references :author, index: true
      t.references :node, index: true
      t.text :body

      t.timestamps null: false
    end
  end
end

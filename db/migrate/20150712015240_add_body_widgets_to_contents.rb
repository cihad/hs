class AddBodyWidgetsToContents < ActiveRecord::Migration
  def change
    add_column :contents, :body_widgets, :text, default: "[]", null: false
  end
end

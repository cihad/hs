class AddBodyWidgetsToProducts < ActiveRecord::Migration
  def change
    add_column :products, :body_widgets, :text, default: "[]", null: false
  end
end

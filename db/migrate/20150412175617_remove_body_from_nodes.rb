class RemoveBodyFromNodes < ActiveRecord::Migration
  def change
    remove_column :nodes, :body, :string
  end
end

class AddStatusToNodes < ActiveRecord::Migration
  def change
    add_column :nodes, :status, :string
    add_index :nodes, :status
  end
end

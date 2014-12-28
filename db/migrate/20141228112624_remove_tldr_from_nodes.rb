class RemoveTldrFromNodes < ActiveRecord::Migration
  def change
    remove_column :nodes, :tldr
  end
end

class AddAuthorToNode < ActiveRecord::Migration
  def change
    add_reference :nodes, :author, index: true
  end
end

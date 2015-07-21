class AddEmailAndApprovedToComment < ActiveRecord::Migration
  def change
    add_column :comments, :email, :string
    add_column :comments, :approved, :boolean
  end
end

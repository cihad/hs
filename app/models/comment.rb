class Comment < ActiveRecord::Base

  # Associations
  belongs_to :author, class_name: "User"
  belongs_to :node

  # Validations
  validates :body, :author_id, :node_id, presence: true
end

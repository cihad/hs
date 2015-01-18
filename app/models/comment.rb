class Comment < ActiveRecord::Base

  # Associations
  belongs_to :author, class_name: "User"
  belongs_to :node, touch: true

  # Validations
  validates :body, :author_id, :node_id, presence: true

  def owner? user
    author_id == user.try(:id)
  end
end

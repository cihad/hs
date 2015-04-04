class Comment < ActiveRecord::Base

  # Associations
  belongs_to :author, class_name: "User", required: true
  belongs_to :node, touch: true, required: true

  # Validations
  validates :body, :author_id, :node_id, presence: true

  def owner? user
    author_id == user.try(:id)
  end
end

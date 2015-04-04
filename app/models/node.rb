class Node < ActiveRecord::Base

  # Associations
  belongs_to :content, polymorphic: true, dependent: :destroy
  include Taggable
  belongs_to :author, class_name: "User"
  has_many :comments, dependent: :destroy

  # Scopes
  scope :published, -> { where(status: "published") }

  # Workflow
  include Workflow
  workflow_column :status
  workflow do
    state :awaiting_review do
      event :review, transitions_to: :being_reviewed
    end

    state :being_reviewed do
      event :accept, transitions_to: :published
      event :reject, transitions_to: :trashed
    end

    state :published do
      event :reject, transitions_to: :trashed
    end

    state :trashed do
      event :accept, transitions_to: :published
    end
  end

  def owner? user
    author_id == user.try(:id)
  end
end

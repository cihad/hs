class Node < ActiveRecord::Base

  # Validations
  validates :title, presence: true
  validates :body, presence: true

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
end

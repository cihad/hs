class Node < ActiveRecord::Base

  # Validations
  validates :title, presence: true
  validates :body, presence: true

  # Associations
  has_many :node_images
  accepts_nested_attributes_for :node_images,
    reject_if: proc { |attrs| attrs[:image_attributes].has_key?(:title) and attrs[:image_attributes][:title].blank? },
    allow_destroy: true
  has_many :images, -> { order 'node_images.position' }, through: :node_images
  include Taggable
  belongs_to :author, class_name: "User"

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

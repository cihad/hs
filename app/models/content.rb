class Content < ActiveRecord::Base

  # Asscoiations
  has_one :node, as: :content, autosave: true, required: true
  accepts_nested_attributes_for :node
  has_many :content_images, dependent: :destroy
  accepts_nested_attributes_for :content_images,
    reject_if: proc { |attrs| attrs[:image_attributes].has_key?(:title) and attrs[:image_attributes][:title].blank? },
    allow_destroy: true
  has_many :images, through: :content_images

  # Validations
  validates_presence_of :title, :body

  # Callbacks
  before_save :update_node_attributes

  def searchable_text_for_body
    body
  end

  def searchable_text_for_title
    title
  end

private

  def update_node_attributes
    node.title  = searchable_text_for_title
    node.body   = searchable_text_for_body
  end

end

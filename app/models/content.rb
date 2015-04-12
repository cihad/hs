class Content < ActiveRecord::Base

  # Full text search
  include PgSearch
  multisearchable against: %i(title body)
  pg_search_scope :search, against: { title: 'A', body: 'B' },
                  :using => {
                    :tsearch => {:any_word => true}
                  }

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

private

  def update_node_attributes
    node.title = title
  end

end

class Image < ActiveRecord::Base

  # Carrierwave Uploader
  mount_uploader :image, ImageUploader

  # Associations
  has_many :node_images, dependent: :destroy
  has_many :nodes, through: :node_images

  # Validations
  validates :title, :image, presence: true

  # Callbacks
  after_destroy :delete_from_nodes

  private

  def delete_from_nodes
    nodes.each do |node|
      node.images.delete(self)
    end
  end
  
end

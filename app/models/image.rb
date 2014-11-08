class Image < ActiveRecord::Base

  # Carrierwave Uploader
  mount_uploader :image, ImageUploader

  # Associations
  has_many :node_images
  has_many :nodes, through: :node_images
  include Taggable

  # Validations
  validates :title, :image, presence: true
  
end

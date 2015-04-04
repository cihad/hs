class Image < ActiveRecord::Base

  # Carrierwave Uploader
  mount_uploader :image, ImageUploader

  # Associations
  has_many :content_images, dependent: :destroy
  has_many :contents, through: :content_images, dependent: :destroy

  # Validations
  validates :title, :image, presence: true  
end

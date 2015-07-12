class Image < ActiveRecord::Base

  # Carrierwave Uploader
  mount_uploader :image, ImageUploader

  # Associations
  belongs_to :imageable, polymorphic: true

  # Validations
  validates :image, presence: true
end

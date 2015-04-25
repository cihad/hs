module Imageable
  extend ActiveSupport::Concern

  included do
    has_many :content_images, dependent: :destroy
    accepts_nested_attributes_for :content_images,
      reject_if: proc { |attrs| attrs[:image_attributes].has_key?(:title) and attrs[:image_attributes][:title].blank? },
      allow_destroy: true
    has_many :images, through: :content_images
  end

end
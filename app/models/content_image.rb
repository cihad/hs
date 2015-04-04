class ContentImage < ActiveRecord::Base

  # Associations
  belongs_to :content, required: true
  belongs_to :image, validate: false, required: true
  accepts_nested_attributes_for :image
  
end

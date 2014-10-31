class NodeImage < ActiveRecord::Base

  # Associations
  belongs_to :node
  belongs_to :image, validate: false
  accepts_nested_attributes_for :image
  
end

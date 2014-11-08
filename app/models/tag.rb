class Tag < ActiveRecord::Base

  # Validations
  validates :name, presence: true, uniqueness: { case_sensitive: false }

  # Associations
  has_many :taggings
  has_many :nodes, through: :taggings, source: :taggable, source_type: "Node"
  has_many :images, through: :taggings, source: :taggable, source_type: "Image"
  
end

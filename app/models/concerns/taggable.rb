using TurkishSupport

module Taggable
  extend ActiveSupport::Concern

  included do
    has_many :taggings, as: :taggable, dependent: :destroy
    has_many :tags, through: :taggings
  end

  def tag_list
    tags.map(&:name).join(', ')
  end

  def tag_list=(tag_list)
    self.tags = tag_list.map { |tag_name| Tag.find_or_create_by(name: tag_name ) }
  end

end
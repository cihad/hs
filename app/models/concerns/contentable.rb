module Contentable
  extend ActiveSupport::Concern

  included do
    has_one :node, as: :content, autosave: true, required: true
    accepts_nested_attributes_for :node
    before_save :update_node_attributes
  end

  private
  
  def update_node_attributes
    node.title = title
  end

end
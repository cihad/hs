require 'product_json_to_model'

class ContentsController < ContentController

  layout "editor"

  before_filter :convert_params!, only: %i(create update)

  private

  def content_resource
    Content
  end

  def convert_params!
    ProductJsonToModel.new(params, @content).convert!
  end

end
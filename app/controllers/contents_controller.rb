require 'product_json_to_model'

class ContentsController < ContentController

  layout "editor"

  before_filter :convert_params!, only: %i(create update)

  def new
    super
    5.times { @content.content_images.build.build_image }
  end

  def edit
    super
    5.times { @content.content_images.build.build_image }
  end

  private

  def content_resource
    Content
  end

  def convert_params!
    ProductJsonToModel.new(params, @content).convert!
  end

end
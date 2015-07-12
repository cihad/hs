require 'product_json_to_model'

class ProductsController < ContentController

  layout "editor"

  before_filter :convert_params!, only: %i(create update)

  private

  def convert_params!
    ProductJsonToModel.new(params, @content).convert!
  end

  def content_resource
    Product
  end

end
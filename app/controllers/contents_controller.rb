class ContentsController < ContentController

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


end
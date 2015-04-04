class ContentsController < ApplicationController
  before_filter :content, only: %i(show edit destroy update)

  def new
    authorize Content
    @content = Content.new
    @node = @content.build_node(author: current_user)

    5.times { @content.content_images.build.build_image }
  end

  def create
    authorize Content
    @content = Content.new
    @content.build_node(author: current_user)
    @content.assign_attributes content_params

    if @content.save
      redirect_to @content.node, notice: I18n.t('nodes.flash.created')
    else
      render action: 'new'
    end
  end

  def edit
    authorize @content
    @content.node.review! if @content.node.awaiting_review?
    5.times { @content.content_images.build.build_image }
  end

  def update
    authorize @content

    if @content.update(content_params)
      redirect_to @content.node, notice: I18n.t('nodes.flash.updated')
    else
      render action: :edit
    end
  end

private

    def content
      @content = Content.find(params[:id])  
    end

    def content_params
      params.require(:content).permit(*policy(@content || Content).permitted_attributes)
    end

end
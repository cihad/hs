class ContentController < ApplicationController

  before_filter :content, only: %i(show edit destroy update)
  before_filter :authorize_content, only: %i(edit update)
  before_filter :authorize_content_resource, only: %i(new create)

  respond_to :json, only: %i(create update)

  def new
    @content = content_resource.new
    @node = @content.build_node(author: current_user)
  end

  def create
    @content = content_resource.new
    @content.build_node(author: current_user)
    @content.assign_attributes content_params
    @content.node.content_type = content_resource

    if @content.save
      render json: { redirect_path: node_path(@content.node) }
    else
      render action: 'new'
    end
  end

  def edit
    @content.node.review! if @content.node.awaiting_review?
  end

  def update
    if @content.update(content_params)
      render json: { redirect_path: node_path(@content.node) }
    else
      render action: :edit
    end
  end

  private

  def content
    @content = content_resource.find(params[:id])  
  end

  def content_params
    params.require(content_resource.to_s.underscore.to_sym).permit(*policy(@content || content_resource).permitted_attributes)
  end

  def content_resource
    Content
  end

  def authorize_content
    authorize @content      
  end

  def authorize_content_resource
    authorize content_resource
  end

end
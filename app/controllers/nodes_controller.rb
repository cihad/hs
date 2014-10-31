class NodesController < ApplicationController

  before_filter :node, only: [:show, :edit, :update]

  def index
    @nodes = Node.with_published_state.order(created_at: :desc)
  end

  def new
    @node = Node.new
    5.times { @node.node_images.build.build_image }
  end

  def create
    @node = Node.new(node_params)

    if @node.save
      redirect_to @node, notice: I18n.t('nodes.flash.created')
    else
      render action: 'new'
    end
  end

  def show
  end

  def edit
    5.times { @node.node_images.build.build_image }
  end

  def update
    if @node.update(node_params)
      redirect_to @node, notice: I18n.t('nodes.flash.updated')
    else
      render action: :new
    end
  end

  def destroy
  end

  private

    def node_params
      params.require(:node).permit(:title, :tldr, :body,
        node_images_attributes: [:_destroy, :id, image_attributes: [:id, :image, :title]])
    end

    def node
      @node = Node.find(params[:id])
    end
end

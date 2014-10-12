class NodesController < ApplicationController
  def index
  end

  def new
    @node = Node.new
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
    @node = Node.find(params[:id])
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

    def node_params
      params.require(:node).permit(:title, :tldr, :body)
    end
end

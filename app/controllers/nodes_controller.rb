class NodesController < ApplicationController

  before_filter :node, only: [:show, :destroy]

  def index
    @nodes = Node.includes(:author, :comments).with_published_state.order(created_at: :desc).page(params[:page])
  end

  def new
  end

  def show
  end

  def destroy
    authorize @node
    @node.destroy
    redirect_to root_path, notice: I18n.t('nodes.flash.destroyed')
  end

  private

    def node
      @node = Node.includes(:content, :author, :comments).find(params[:id])
    end
end

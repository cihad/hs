class NodesController < ApplicationController

  before_filter :node, only: [:show, :destroy]
  layout "page", only: %i(new show)

  def index
    @nodes = Node.includes(:author, :comments, :content).
                  with_published_state.
                  order(created_at: :desc).
                  page(params[:page])
  end

  def new
  end

  def show
    table = Comment.arel_table
    @comments = @node.comments.
                      where(table[:author_id].not_eq(nil).or(table[:approved].eq(true))).
                      order(:created_at)
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

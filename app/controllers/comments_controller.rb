class CommentsController < ApplicationController

  before_action :set_node
  before_action :set_comment, only: [:edit, :update, :destroy]

  respond_to :html

  def create
    @comment = Comment.new(comment_params).tap do |c|
      c.author  = current_user
      c.node    = @node
    end

    if @comment.save
      redirect_to @node, notice: I18n.t('comments.flash.created')
    else
      render "nodes/show"
    end
  end

  def edit
    authorize @comment
  end

  def update
    if @comment.update(comment_params)
      redirect_to comment_path(@comment)
    else
      render :edit
    end
  end

  def destroy
    @comment.destroy
    redirect_to @node, notice: I18n.t('comments.flash.destroyed')
  end

  private
    def set_comment
      @comment = Comment.find(params[:id])
    end 

    def set_node
      @node = Node.includes(:comments).find(params[:node_id])
    end

    def comment_params
      params.require(:comment).permit(:body)
    end

end

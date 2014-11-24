class CommentsController < ApplicationController

  before_action :set_node
  before_action :set_comment, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def show
    respond_with(@comment)
  end

  def create
    @comment = Comment.new(comment_params).tap do |c|
      c.author  = current_user
      c.node    = @node
    end

    @comment.save
    redirect_to @node, notice: "Comment created."
  end

  def update
    @comment.update(comment_params)
    respond_with(@comment)
  end

  def destroy
    @comment.destroy
    respond_with(@comment)
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

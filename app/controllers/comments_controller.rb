class CommentsController < ApplicationController

  before_action :set_node
  before_action :set_comment, only: [:edit, :update, :destroy, :authenticate]

  respond_to :html

  layout 'page'

  def create
    @comment = Comment.new(comment_params).tap do |c|
      c.approved = current_user.registered?
      c.author  = current_user if current_user.registered?
      c.node    = @node
    end


    if @comment.save
      if @comment.email and !@comment.author and current_user.anonymous?
        CommentMailer.authentication(@comment).deliver_now!
        redirect_to @node, notice: I18n.t('comments.flash.awaiting_authenticate')
      else
        redirect_to @node, notice: I18n.t('comments.flash.created')
      end
    else
      @comments = @node.comments.approved_or_commented_by_user_comments
      render "nodes/show"
    end
  end

  def authenticate
    if @comment.valid_key? params[:key] and @comment.update approved: true
      if user = User.find_by(email: @comment.email)
        @comment.update author: user
      end
      redirect_to @node, notice: I18n.t('comments.flash.approved')
    else
      redirect_to @node, notice: I18n.t('comments.flash.not_approved')
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
      params.require(:comment).permit(*policy(@comment || Comment).permitted_attributes)
    end

end

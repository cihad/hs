class CommentMailer < ApplicationMailer

  def authentication comment
    @comment = comment
    mail to: comment.email
  end
end

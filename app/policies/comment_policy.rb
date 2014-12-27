class CommentPolicy < Struct.new(:current_user, :comment)

  def new?
    create?
  end

  def create?
    current_user.registered?
  end

  def update?
    comment.owner?(current_user) or current_user.manager?
  end

  def edit?
    update?
  end

end
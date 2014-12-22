class CommentPolicy < Struct.new(:current_user, :comment)

  def new?
    create?
  end

  def create?
    current_user.present?
  end

  def update?
    (current_user == comment.author) or
      current_user.try(:admin?) or
        current_user.try(:superadmin?)
  end

  def edit?
    update?
  end

end
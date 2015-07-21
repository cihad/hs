class CommentPolicy < Struct.new(:current_user, :comment)

  def new?
    create?
  end

  def create?
    true
  end

  def update?
    comment.owner?(current_user) or current_user.manager?
  end

  def edit?
    update?
  end

  def destroy?
    update?
  end

  def permitted_attributes
    # Comment attributes
    attrs = [:body]
    
    attrs << :email if current_user.anonymous?

    # Return attributes
    attrs
  end

end
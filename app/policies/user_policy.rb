class UserPolicy < Struct.new(:current_user, :user)

  def edit?
    update?
  end

  def update?
    user == current_user or current_user.superadmin?
  end

end
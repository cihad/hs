class ImagePolicy < Struct.new(:current_user, :image)

  def edit?
    update?
  end

  def update?
    current_user.manager?
  end

end
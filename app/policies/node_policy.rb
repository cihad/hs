class NodePolicy < Struct.new(:current_user, :node)

  def new?
    create?
  end

  def update?
    node.owner?(current_user) or current_user.chef?(node.author)
  end

  def edit?
    update?
  end

  def create?
    current_user.is_greater_than? :anonymous
  end

end
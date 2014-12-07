class NodePolicy < Struct.new(:current_user, :node)

  def new?
    create?
  end

  def create?
    current_user.present? \
      and
    (current_user.authenticated? or
      current_user.admin? or
        current_user.superadmin?)
  end

end
class DashboardPolicy < ApplicationPolicy

  def show?
    user.present? and user.manager?
  end

end
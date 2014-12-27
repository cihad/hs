class DashboardPolicy < ApplicationPolicy

  def show?
    user.manager?
  end

end
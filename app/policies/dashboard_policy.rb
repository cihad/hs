class DashboardPolicy < ApplicationPolicy

  def show?
    user.present? \
      and
    (user.admin? or user.superadmin?)
  end

end
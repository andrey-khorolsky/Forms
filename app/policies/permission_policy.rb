class PermissionPolicy < ApplicationPolicy
  def index?
    user.admin_for?(record.id)
  end

  def update?
    user.admin_for?(record.id)
  end

  def show?
    user.admin_for?(record.id)
  end

  def destroy?
    user.admin_for?(record.id)
  end
end

class GroupPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    user.role_for_entity?(record.id)
  end

  def create?
    true
  end

  def update?
    user.admin_for?(record.id)
  end

  def destroy?
    user.admin_for?(record.id)
  end

  def show_members?
    user.role_for_entity?(record.id)
  end

  def create_member?
    user.admin_for?(record.id)
  end
end

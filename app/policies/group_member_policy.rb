class GroupMemberPolicy < ApplicationPolicy
  def show?
    user.manager_or_admin?(record.id)
  end

  def destroy?
    user.admin_for?(record.id)
  end
end

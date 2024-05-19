class AnswerPolicy < ApplicationPolicy
  def show?
    user.manager_or_admin?(record.id)
  end

  def destroy?
    user.manager_or_admin?(record.id)
  end
end

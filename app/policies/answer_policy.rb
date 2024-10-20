class AnswerPolicy < ApplicationPolicy
  def show?
    user.manager_or_admin?(record.survey)
  end

  def destroy?
    user.manager_or_admin?(record.survey) && record.user == user
  end
end

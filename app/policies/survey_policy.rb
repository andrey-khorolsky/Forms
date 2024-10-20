class SurveyPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    !record.private || user.role_for_entity?(record.id)
  end

  def create?
    true
  end

  def destroy?
    user.admin_for?(record.id)
  end

  def index_answer?
    user.manager_or_admin?(record.id)
  end

  def create_answer?
    !record.private || user.role_for_entity?(record.id)
  end

  def get_statistics?
    user.manager_or_admin?(record.id)
  end

  def create_permission?
    user.admin_for?(record.id)
  end
end

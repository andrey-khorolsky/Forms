class SurveyPolicy < ApplicationPolicy
  def index_answer?
    user.manager_or_admin?(record.id)
  end

  def create_answer?
    !record.anonymous || (record.anonymous && User.find(user_id).role_for_entity?(id))
  end

  def get_statistics?
    user.manager_or_admin?(record.id)
  end
end

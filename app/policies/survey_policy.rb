class SurveyPolicy < ApplicationPolicy
  def get_statistics?
    user.manager_or_admin?(record.id)
  end
end

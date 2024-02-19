class User < ApplicationRecord
  include Owner

  validates :name, presence: true

  has_many :answers

  has_many :group_members, as: :member
  has_many :groups, through: :group_members

  def answers_for_survey(survey_id)
    answers.where(survey_id: survey_id)
  end
end

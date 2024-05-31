class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable,
    :jwt_authenticatable, jwt_revocation_strategy: self
  include Devise::JWT::RevocationStrategies::JTIMatcher

  include Owner
  include Participant

  validates :name, presence: true

  has_many :answers

  def answers_for_survey(survey_id)
    answers.where(survey_id: survey_id)
  end
end

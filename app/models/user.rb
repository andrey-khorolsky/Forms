class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable,
    :jwt_authenticatable, jwt_revocation_strategy: self
  include Devise::JWT::RevocationStrategies::JTIMatcher
  include Owner

  validates :name, presence: true

  has_many :answers

  has_many :group_members, as: :member
  has_many :groups, through: :group_members

  def answers_for_survey(survey_id)
    answers.where(survey_id: survey_id)
  end
end

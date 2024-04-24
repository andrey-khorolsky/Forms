class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers: [:google_oauth2]

  include Owner

  validates :name, presence: true

  has_many :answers

  has_many :group_members, as: :member
  has_many :groups, through: :group_members

  def answers_for_survey(survey_id)
    answers.where(survey_id: survey_id)
  end

  def self.from_omniauth(access_token)
    data = access_token.info
    user = User.find_by(email: data["email"])

    user || User.create(
      email: data["email"],
      password: Devise.friendly_token[0, 20]
    )
  end
end

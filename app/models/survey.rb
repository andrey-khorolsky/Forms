class Survey < ApplicationRecord
  include Stored

  mount_uploader :wallpaper, SurveyWallpaperUploader

  validates :name, :question_mongo_id, presence: true
  validate :completion_by_person, :positive_completion_by_person

  has_many :answers, dependent: :destroy

  scope :with_question, -> { where(question_mongo_id: Question.ids) }

  # association with question model in mongo
  def question
    Question.find_by(id: question_mongo_id)
  rescue Mongoid::Errors::DocumentNotFound
    nil
  end

  def can_user_answer?(user_id)
    completion_by_person.nil? || (completion_by_person.to_i < answers.where(user_id: user_id).count)
  end

  private

  def positive_completion_by_person
    if completion_by_person.present? && completion_by_person.to_i <= 0
      errors.add(:completion_by_person, "Must be greater than 0")
    end
  end
end

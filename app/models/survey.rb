class Survey < ApplicationRecord
  include Stored

  mount_uploader :wallpaper, SurveyWallpaperUploader

  validates :name, :actived, :question_mongo_id, presence: true

  has_many :answers, dependent: :destroy

  # association with question model in mongo
  def question
    Question.find_by(id: question_mongo_id)
  rescue Mongoid::Errors::DocumentNotFound
    nil
  end

  def can_user_answer?(user_id)
    true if completion_by_person.nil? || (completion_by_person < answers.where(user_id: user_id).count)
  end
end

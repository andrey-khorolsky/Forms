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
end

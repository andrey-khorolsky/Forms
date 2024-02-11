class Survey < ApplicationRecord
  validates :name, :actived, :private, presence: true

  def question
    Question.find_by(survey_id: id)
  rescue Mongoid::Errors::DocumentNotFound
    nil
  end
end

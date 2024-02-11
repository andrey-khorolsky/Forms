class Survey < ApplicationRecord
  include Stored

  validates :name, :actived, presence: true

  def question
    Question.find_by(survey_id: id)
  rescue Mongoid::Errors::DocumentNotFound
    nil
  end
end

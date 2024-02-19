class Answer < ApplicationRecord
  validates :user_id, :survey_id, :answer_id, presence: true

  belongs_to :user
  belongs_to :survey

  def answer_data
    AnswerDatum.find_by(answer_id: id)
  rescue Mongoid::Errors::DocumentNotFound
    nil
  end
end

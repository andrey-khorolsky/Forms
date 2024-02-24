class Answer < ApplicationRecord
  before_destroy :destroy_answer_data

  validates :user_id, :survey_id, :answer_id, presence: true

  belongs_to :user
  belongs_to :survey

  def answer_data
    AnswerDatum.find_by(id: answer_id)
  rescue Mongoid::Errors::DocumentNotFound
    nil
  end

  private

  def destroy_answer_data
    answer_data&.destroy
  end
end

class Survey < ApplicationRecord
  include Stored

  before_destroy :destroy_questions

  validates :name, :actived, :question_id, presence: true

  has_many :answers, dependent: :destroy

  def question
    Question.find_by(id: question_id)
  rescue Mongoid::Errors::DocumentNotFound
    nil
  end

  private

  def destroy_questions
    question&.destroy
  end
end

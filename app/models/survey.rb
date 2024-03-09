class Survey < ApplicationRecord
  include Stored

  validates :name, :actived, :question_id, presence: true

  has_many :answers, dependent: :destroy

  # association with question model in mongo
  def question
    Question.find_by(id: question_id)
  rescue Mongoid::Errors::DocumentNotFound
    nil
  end
end

class Survey < ApplicationRecord
  include Stored

  validates :name, :actived, :question_id, presence: true

  has_many :answers

  def question
    Question.find_by(id: question_id)
  rescue Mongoid::Errors::DocumentNotFound
    nil
  end
end

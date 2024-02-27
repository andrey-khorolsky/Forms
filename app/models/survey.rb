class Survey < ApplicationRecord
  include Stored

  before_destroy :destroy_questions

  validates :name, :actived, :question_id, presence: true

  has_many :answers, dependent: :destroy

  def initialize(attributes)
    questions = Question.new(questions_count: attributes[:questions_count], questions: attributes[:questions])

    return unless questions.save
    super(attributes.except(:questions, :questions_count))

    update(question_id: questions.id.to_s)
  end

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

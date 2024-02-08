class Survey < ApplicationRecord
  # belongs_to :owner, polymorphic: true  # wait for user

  def question
    Question.find_by(survey_id: id)
  rescue Mongoid::Errors::DocumentNotFound
    nil
  end
end

class AnswerDatum
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Attributes::Dynamic

  field :questions_count, type: Integer # count of answered question

  def answer
    Answer.find_by(answer_id: id.to_s)
  end
end

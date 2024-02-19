class Question
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Attributes::Dynamic

  field :questions_count, type: Integer # count of questions

  def survey
    Survey.find_by(question_id: id.to_s)
  end
end

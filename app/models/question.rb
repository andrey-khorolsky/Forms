class Question
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Attributes::Dynamic

  field :survey_id, type: String  # id of survey
  field :questions_count, type: Integer # count of questions

  def survey
    Survey.find(survey_id)
  end
end

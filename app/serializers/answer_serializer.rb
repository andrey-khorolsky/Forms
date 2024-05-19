class AnswerSerializer
  include JSONAPI::Serializer
  attributes :survey_id, :created_at

  attribute :user_id, if: proc { |object| !object.survey.anonymous }

  attribute :answer_data do |object|
    object.answer_data.attributes.except("_id", "created_at", "updated_at")
  end

  belongs_to :user, if: proc { |object| !object.survey.anonymous }
  belongs_to :survey
end

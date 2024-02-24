class AnswerSerializer
  include JSONAPI::Serializer
  attributes :user_id, :survey_id, :created_at

  attribute :answer_data do |object|
    object.answer_data.attributes.except("_id", "created_at", "updated_at")
  end

  belongs_to :user
  belongs_to :survey
end

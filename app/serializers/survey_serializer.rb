class SurveySerializer
  include JSONAPI::Serializer

  attributes :name, :actived, :private, :start_date, :end_date, :created_at

  has_many :owners do |object|
    object.owners
  end

  attribute :questions do |object|
    object.question.attributes.except("_id", "created_at", "updated_at")
  end
end

class SurveySerializer
  include JSONAPI::Serializer

  attributes :name, :actived, :private, :start_date, :end_date, :created_at

  attribute :questions do |object|
    object.question.attributes.except("_id", "created_at", "updated_at")
  end

  has_many :answers

  has_many :owners do |object|
    object.owners
  end
end

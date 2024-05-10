class SurveySerializer
  include JSONAPI::Serializer

  attributes :name, :actived, :private, :start_date, :end_date, :created_at, :wallpaper_url,
    :description, :anonymous, :completion_time, :completion_by_person, :needed_votes

  attribute :questions do |object|
    object.question.attributes.except("_id", "created_at", "updated_at")
  end

  attribute :has_enough_answers do |object|
    object.needed_votes.to_i >= object&.answers&.count
  end

  has_many :answers

  has_many :owners do |object|
    object.owners
  end

  link :self do |object|
    "/surveys/#{object.id}"
  end
end

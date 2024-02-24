class SurveySerializer < Panko::Serializer
  attributes :name, :actived, :private, :start_date, :end_date, :created_at, :owners, :questions

  def owners
    object.owners
  end

  def questions
    object.question.attributes.except("_id", "created_at", "updated_at")
  end
end

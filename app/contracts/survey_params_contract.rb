class SurveyParamsContract < Dry::Validation::Contract
  params(QuestionContract.schema) do
    required(:name).filled(:string)
    optional(:description).filled(:string)
    optional(:wallpaper).value(type?: ActionDispatch::Http::UploadedFile)

    optional(:actived).filled(:bool)
    optional(:private).filled(:bool)
    optional(:anonymous).filled(:bool)

    optional(:start_date).filled(:date_time)
    optional(:end_date).maybe(:date_time)

    optional(:completion_time).maybe(:string)
    optional(:completion_by_person).maybe(:string)
    optional(:needed_votes).maybe(:string)
  end

  rule(:wallpaper) do
    if value.present? && !value.content_type.in?(["image/png", "image/jpeg"])
      key.failure("It's not a png or jpeg file")
    end
  end
end

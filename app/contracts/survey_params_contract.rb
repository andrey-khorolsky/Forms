class SurveyParamsContract < Dry::Validation::Contract
  params(QuestionContract.schema) do
    required(:name).filled(:string)
    optional(:actived).filled(:bool)
    optional(:private).filled(:bool)
    optional(:start_date).filled(:date_time)
    optional(:end_date).filled(:date_time)
    optional(:wallpaper).value(type?: ActionDispatch::Http::UploadedFile)
  end

  rule(:wallpaper) do
    key.failure("It's not a png or jpeg file") unless value.content_type.in?(["image/png", "image/jpeg"])
  end
end

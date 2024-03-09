class SurveyParamsContract < Dry::Validation::Contract
  params(QuestionContract.schema) do
    required(:name).filled(:string)
    optional(:actived).filled(:bool)
    optional(:private).filled(:bool)
    optional(:start_date).filled(:date_time)
    optional(:end_date).filled(:date_time)
  end
end

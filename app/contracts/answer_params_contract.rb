class AnswerParamsContract < Dry::Validation::Contract
  params(AnswerContract.schema) do
    required(:survey_id).filled(:string)
  end
end

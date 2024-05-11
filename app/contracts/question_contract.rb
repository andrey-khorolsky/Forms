class QuestionContract < Dry::Validation::Contract
  params do
    required(:questions_count).filled(:integer)
    required(:questions).array(:hash) do
      required(:id).filled(:string)
      required(:number).filled(:integer)
      required(:type).filled(:string)
      required(:text).filled(:string)
      optional(:required).filled(:bool)
      optional(:hint).filled(:string)

      optional(:subform).array(:hash) do
        required(:id).filled(:string)
        required(:number).filled(:integer)
        required(:text).filled(:string)
      end
    end
  end

  rule(:questions) do
    unless value.map { _1[:number] } == (1..values[:questions_count]).to_a
      key.failure("Expected questions count and actual questions count not matches")
    end
  end
end

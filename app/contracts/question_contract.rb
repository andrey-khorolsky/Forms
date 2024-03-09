class QuestionContract < Dry::Validation::Contract
  params do
    required(:questions_count).filled(:integer)
    required(:questions).array(:hash) do
      required(:number).filled(:integer)
      required(:type).filled(:string)
      required(:text).filled(:string)
      optional(:required).filled(:bool)
    end
  end

  rule(:questions) do
    unless value.map { _1[:number] } == (1..values[:questions_count]).to_a
      key.failure("Expected questions count and actual questions count not matches")
    end
  end
end

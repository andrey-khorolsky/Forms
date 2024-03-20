class AnswerContract < Dry::Validation::Contract
  params do
    required(:answers_count).filled(:integer)
    required(:answer_data).array(:hash) do
      required(:number).filled(:integer)
      required(:result).filled(:string)
    end
  end

  rule(:answer_data) do
    unless value.map { _1[:number] } == (1..values[:answers_count]).to_a
      key.failure("Expected answers count and actual answers count not matches")
    end
  end
end

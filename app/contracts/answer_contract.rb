class AnswerContract < Dry::Validation::Contract
  OneAnswer = Dry::Schema.Params do
    required(:number).filled(:integer)
    required(:result).filled(:string)
  end

  MultipleAnswer = Dry::Schema.Params do
    required(:number).filled(:integer)
    required(:result).array(:string)
  end

  params do
    required(:answers_count).filled(:integer)
    optional(:answer_time).filled(:string)
    required(:answer_data).array(:hash) do
      OneAnswer.or(MultipleAnswer)
    end
  end

  # rule(:answer_data) do
  #   unless value.map { _1[:number] } == (1..values[:answers_count]).to_a
  #     key.failure("Expected answers count and actual answers count not matches")
  #   end
  # end
end

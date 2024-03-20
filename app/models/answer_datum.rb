class AnswerDatum
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Attributes::Dynamic

  field :answers_count, type: Integer # count of answered question
  field :answer_data, type: Array

  validate :schema_validation

  def answer
    Answer.find_by(answer_mongo_id: id.to_s)
  end

  private

  def schema_validation
    validation_result = AnswerContract.new.call(attributes)

    return if validation_result.success?

    validation_result.errors.to_a.each do |error|
      errors.add(error.path.first, "#{error.path} #{error.text}")
    end
  end
end

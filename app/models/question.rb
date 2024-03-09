class Question
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Attributes::Dynamic

  field :questions_count, type: Integer # count of questions

  validates :questions_count, presence: true, numericality: {only_integer: true}
  validate :schema_validation

  def survey
    Survey.find_by(question_id: id.to_s)
  end

  private

  def schema_validation
    validation_result = QuestionContract.new.call(attributes)

    return if validation_result.success?

    validation_result.errors.to_a.each do |error|
      errors.add(error.path.first, "#{error.path} #{error.text}")
    end
  end
end

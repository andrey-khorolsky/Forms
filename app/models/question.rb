class Question
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Attributes::Dynamic

  field :questions_count, type: Integer # count of questions

  validates :questions_count, presence: true, numericality: {only_integer: true}

  def initialize(attributes)
    super(attributes.except(:questions))

    attributes[:questions].each do |field|
      update("field_#{field[:number]}" => field.except(:number).to_h)
    end
  end

  def survey
    Survey.find_by(question_id: id.to_s)
  end
end

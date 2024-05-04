class AnswerStatisticsSerializer < Panko::Serializer
  attributes :all_answer_count, :answer_statistics, :time_statistics

  def all_answer_count
    object.answers.count
  end

  def answer_statistics
    except_question_numbers = if context&.key?(:except_question_numbers) && context[:except_question_numbers].present?
      context[:except_question_numbers].split(",").map(&:to_i)
    else
      []
    end

    object.survey.question.questions.reject { _1[:number].in?(except_question_numbers) }.map do |question|
      {
        number: question[:number],
        answer_count: object.get_answer_count(question[:number]),
        different_answer_count: object.get_different_answer_count(question[:number]),
        average_value: object.get_average_value(question[:number]),
        min_value: object.get_min_value(question[:number]),
        max_value: object.get_max_value(question[:number]),
        answers: object.get_answers(question[:number])
      }
    end
  end

  def time_statistics
    {
      first_answer: object.answers.pluck(:created_at).min,
      last_answer: object.answers.pluck(:created_at).max,
      timechart: object.get_timechart
    }
  end
end

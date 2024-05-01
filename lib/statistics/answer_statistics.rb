module Statistics
  class AnswerStatistics
    def initialize(survey, date_from = nil, date_to = nil)
      @survey = survey
      @answers = survey.answers.where(get_date_range(date_from, date_to))
    end

    def get_statistic(except_question_numbers)
      return nil if @survey.question.nil?
      except_question_numbers = except_question_numbers.nil? ? [] : except_question_numbers.split(",").map(&:to_i)

      statistic = @survey.question.questions.reject { _1[:number].in?(except_question_numbers) }.map do |question|
        {
          number: question[:number],
          answer_count: get_answer_count(question[:number]),
          different_answer_count: get_different_answer_count(question[:number]),
          answers: get_answers(question[:number])
        }
      end

      {
        answers_statistics: statistic,
        timechart: get_timechart
      }
    end

    private

    def get_answer_count(question_number)
      @answers.count { _1.answer_data.answer_data.detect { |a| a[:number] == question_number } }
    end

    def get_different_answer_count(question_number)
      answers = @answers.map { _1.answer_data.answer_data.detect { |a| a[:number] == question_number } }
      answers.map { _1[:result] }.uniq.count
    end

    def get_answers(question_number)
      all_answers = @answers.map { _1.answer_data.answer_data.detect { |a| a[:number] == question_number } }
      answers = all_answers.map { _1[:result] }
      answers_count = answers.count
      uniq_answers = answers.uniq

      uniq_answers.map do |uniq_answer|
        ans_count = answers.count(uniq_answer)
        [uniq_answer, {
          count: ans_count,
          percent: (ans_count / answers_count.to_f) * 100
        }]
      end.to_h
    end

    def get_timechart
      @answers.pluck(:created_at).map { _1.to_fs(:iso8601) }.uniq.sort.map.with_index { |date, ind| {date => ind + 1} }
    end

    def get_date_range(date_from, date_to)
      return {} if date_from.nil? && date_to.nil?

      {created_at: (date_from..date_to)}
    end
  end
end

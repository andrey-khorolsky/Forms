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
          average_value: get_average_value(question[:number]),
          min_value: get_min_value(question[:number]),
          max_value: get_max_value(question[:number]),
          answers: get_answers(question[:number])
        }
      end

      {
        all_answer_count: @answers.count,
        answers_statistics: statistic,
        time_statistics: {
          first_answer: @answers.pluck(:created_at).min,
          last_answer: @answers.pluck(:created_at).max,
          timechart: get_timechart
        }
      }
    end

    private

    def get_answer_count(question_number)
      get_answer_by_question_number(question_number).count
    end

    def get_different_answer_count(question_number)
      answers = get_answer_by_question_number(question_number)
      answers.map { _1[:result] }.uniq.count
    end

    def get_average_value(question_number)
      return nil unless question_digital_type?(question_number)

      all_answers = get_answer_by_question_number(question_number)
      all_answers.sum { _1[:result] } / all_answers.count.to_f
    end

    def get_min_value(question_number)
      return nil unless question_digital_type?(question_number)

      get_answer_by_question_number(question_number).min { _1[:result] }
    end

    def get_max_value(question_number)
      return nil unless question_digital_type?(question_number)

      get_answer_by_question_number(question_number).max { _1[:result] }
    end

    def get_answers(question_number)
      all_answers = get_answer_by_question_number(question_number)
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
      answer_dates = @answers.pluck(:created_at)
      answer_dates.uniq.sort.map { |date| {date => answer_dates.count { _1 <= date }} }
    end

    def get_date_range(date_from, date_to)
      return {} if date_from.nil? && date_to.nil?

      {created_at: (date_from..date_to)}
    end

    def get_answer_by_question_number(question_number)
      Rails.cache.fetch(question_number) do
        @answers.map { _1.answer_data.answer_data.detect { |a| a[:number] == question_number } }.compact
      end
    end

    def question_digital_type?(question_number)
      ["integer", "float"].include?(@survey.question.get_question_types[question_number])
    end
  end
end

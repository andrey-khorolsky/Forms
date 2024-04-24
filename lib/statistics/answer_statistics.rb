module Statistics
  class AnswerStatistics
    def initialize(survey)
      @survey = survey
      @answers = survey.answers
    end

    def get_statistic
      return nil if @survey.question.nil?

      @survey.question.questions.map do |question|
        {
          number: question[:number],
          answer_count: get_answer_count(question[:number]),
          different_answer_count: get_different_answer_count(question[:number]),
          answers: get_answers(question[:number])
        }
      end
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
  end
end

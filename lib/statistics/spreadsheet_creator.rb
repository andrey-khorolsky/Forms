module Statistics
  class SpreadsheetCreator
    def initialize(survey)
      @survey = survey
      @answers = survey.answers
    end

    def create_spreadsheet
      headers = @survey.question.get_questions_text
      data = @answers.map { _1.answer_data.get_results }
      SpreadsheetArchitect.to_xlsx(headers: headers, data: data)
    end
  end
end

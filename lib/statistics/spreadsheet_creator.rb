module Statistics
  class SpreadsheetCreator
    def initialize(survey)
      @survey = survey
      @answers = survey.answers
    end

    def create_spreadsheet
      headers, data = get_headers_data
      SpreadsheetArchitect.to_xlsx(headers: headers, data: data)
    end

    def create_csv
      headers, data = get_headers_data
      SpreadsheetArchitect.to_csv(headers: headers, data: data)
    end

    # maybe should move to another location
    def create_xml
      headers, data = get_headers_data
      data.map do |row|
        headers.map.with_index do |item, ind|
          [item.delete("?"), row[ind]]
        end.to_h
      end.to_xml(root: "answers")
    end

    private

    def get_headers_data
      [@survey.question.get_questions_text, @answers.map { _1.answer_data.get_results }]
    end
  end
end

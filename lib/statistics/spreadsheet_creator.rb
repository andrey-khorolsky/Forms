module Statistics
  class SpreadsheetCreator
    def initialize(survey)
      @survey = survey
      @answers = survey.answers
    end

    def create_xlsx
      headers, data = get_headers_data
      SpreadsheetArchitect.to_xlsx(headers: headers, data: data)
    end

    def create_csv
      headers, data = get_headers_data
      SpreadsheetArchitect.to_csv(headers: headers, data: data)
    end

    def create_ods
      headers, data = get_headers_data
      SpreadsheetArchitect.to_ods(headers: headers, data: data)
    end

    def create_xml
      headers, data = get_headers_data
      data.map do |row|
        headers.map.with_index do |item, ind|
          [item.delete("?"), row[ind]]
        end.to_h
      end.to_xml(root: "answers")
    end

    def create_yaml
      headers, data = get_headers_data

      headers.map.with_index do |question, question_number|
        [question => data.map { |answers| answers[question_number] }]
      end.to_yaml
    end

    private

    def get_headers_data
      [@survey.question.get_questions_text, @answers.map { _1.answer_data.get_results }]
    end
  end
end

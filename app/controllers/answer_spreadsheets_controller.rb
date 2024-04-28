class AnswerSpreadsheetsController < ApplicationController
  def show
    survey = Survey.find(params[:survey_id])
    raise ActiveRecord::RecordNotFound unless survey.answers.present?

    filename = "#{survey.name} - Ответы"

    case params[:format]
    when "xlsx"
      render xlsx: ::Statistics::SpreadsheetCreator.new(survey).create_spreadsheet, filename: filename
    when "csv"
      render csv: ::Statistics::SpreadsheetCreator.new(survey).create_csv, filename: filename
    end
  end
end

class AnswerSpreadsheetsController < ApplicationController
  def show
    survey = Survey.find(params[:survey_id])
    raise ActiveRecord::RecordNotFound unless survey.answers.present?

    spreadsheet = ::Statistics::SpreadsheetCreator.new(survey).create_spreadsheet
    render xlsx: spreadsheet, filename: "#{survey.name} - Ответы"
  end
end

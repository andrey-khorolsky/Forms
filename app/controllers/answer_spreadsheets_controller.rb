class AnswerSpreadsheetsController < ApplicationController
  before_action :authenticate_user!

  def show
    survey = Survey.find(params[:survey_id])
    raise ActiveRecord::RecordNotFound unless survey.answers.present?

    authorize! survey, to: :get_statistics?

    filename = "#{survey.name} - Ответы"

    case params[:format]
    when "xlsx"
      render xlsx: ::Statistics::SpreadsheetCreator.new(survey).create_xlsx, filename: filename
    when "csv"
      render csv: ::Statistics::SpreadsheetCreator.new(survey).create_csv, filename: filename
    when "xml"
      render xml: ::Statistics::SpreadsheetCreator.new(survey).create_xml, filename: filename
    end
  end
end

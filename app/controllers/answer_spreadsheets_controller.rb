class AnswerSpreadsheetsController < ApplicationController
  before_action :authenticate_user!

  def show
    survey = Survey.find(params[:survey_id])
    raise ActiveRecord::RecordNotFound unless survey.answers.present?

    authorize! survey, to: :get_statistics?

    filename = "#{survey.name} - Ответы #{DateTime.current.strftime "%F-%R"}"
    spreadsheet_creator = ::Statistics::SpreadsheetCreator.new(survey)

    case params[:format]
    when "xlsx"
      render xlsx: spreadsheet_creator.create_xlsx, filename: filename
    when "csv"
      render csv: spreadsheet_creator.create_csv, filename: filename
    when "ods"
      render ods: spreadsheet_creator.create_ods, filename: filename
    when "xml"
      send_data spreadsheet_creator.create_xml, filename: filename + ".xml", type: "text/xml"
    when "yaml"
      send_data spreadsheet_creator.create_yaml, filename: filename + ".yaml", type: "text/yaml"
    end
  end
end

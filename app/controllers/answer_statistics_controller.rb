class AnswerStatisticsController < ApplicationController
  def show
    survey = Survey.find(params[:survey_id])
    raise ActiveRecord::RecordNotFound unless survey.answers.present?

    permitted_params = answer_params
    statistics = ::Statistics::AnswerStatistics.new(survey, permitted_params[:date_from], permitted_params[:date_to])

    render json: AnswerStatisticsSerializer.new(context: {except_question_numbers: permitted_params[:except_question_numbers]})
      .serialize_to_json(statistics)
  end

  private

  def answer_params
    params.permit(:date_from, :date_to, :except_question_numbers)
  end
end

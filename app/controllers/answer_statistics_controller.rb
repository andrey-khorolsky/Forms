class AnswerStatisticsController < ApplicationController
  def index
    survey = Survey.find(params[:survey_id])
    raise ActiveRecord::RecordNotFound unless survey.answers.present?

    statistics = ::Statistics::AnswerStatistics.new(survey).get_statistic
    render json: statistics
  end
end

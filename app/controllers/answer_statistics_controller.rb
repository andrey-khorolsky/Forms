class AnswerStatisticsController < ApplicationController
  def index
    survey = Survey.find(params[:survey_id])
    if survey.answers.present?
      statistics = ::Statistics::AnswerStatistics.new(survey).get_statistic
      render json: statistics
    else
      raise ActiveRecord::RecordNotFound
    end
  end
end

class SurveysController < ApplicationController
  # GET /surveys
  def index
    render json: SurveySerializer.new(Survey.all).serializable_hash.to_json
  end

  # GET /surveys/98e17521-56d6-4ecc-a903-091ff4a387c5
  def show
    render json: SurveySerializer.new(Survey.find(params[:id])).serializable_hash.to_json
  end

  # POST /surveys
  def create
    survey = SurveyRepository.new.create(survey_params)

    if survey.success?
      render json: SurveySerializer.new(survey.success.first).serializable_hash.to_json
    else
      render json: survey.failure, status: 422
    end
  end

  # DELETE /surveys/98e17521-56d6-4ecc-a903-091ff4a387c5
  def destroy
    SurveyRepository.new.destroy(params[:id])
    render json: {}, status: 200
  end

  private

  def survey_params
    params.require(:survey).permit(:name, :actived, :questions_count, :wallpaper, questions: [:number, :type, :text])
  end
end

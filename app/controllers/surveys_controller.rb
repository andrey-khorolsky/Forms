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
    survey = Survey.new(survey_params)

    if survey.save
      render json: SurveySerializer.new(survey).serializable_hash.to_json
    else
      render json: survey.errors, status: 422
    end
  end

  # DELETE /surveys/98e17521-56d6-4ecc-a903-091ff4a387c5
  def destroy
    survey = Survey.find_by(id: params[:id])

    if survey.nil?
      render json: {}, status: 204
    else
      survey.destroy
      render json: {}, status: 200
    end
  end

  private

  def survey_params
    params.require(:survey).permit(:name, :actived, :questions_count, questions: [:number, :type, :text])
  end
end

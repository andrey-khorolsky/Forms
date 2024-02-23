class SurveysController < ApplicationController
  # GET /surveys
  def index
    render json: SurveySerializer.new(Survey.all).serializable_hash.to_json
  end

  # GET /surveys/98e17521-56d6-4ecc-a903-091ff4a387c5
  def show
    render json: SurveySerializer.new(Survey.find(params[:id])).serializable_hash.to_json
  end
end

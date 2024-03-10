class AnswersController < ApplicationController
  before_action :set_survey, only: [:index, :show]

  # GET /surveys/survey_uuid_id/answers
  def index
    render json: AnswerSerializer.new(@survey.answers).serializable_hash.to_json
  end

  # GET /surveys/survey_uuid_id/answers/uuid_id
  def show
    render json: AnswerSerializer.new(@survey.answers.find(params[:id])).serializable_hash.to_json
  end

  # POST /surveys/survey_uuid_id/answers
  def create
    answer = AnswerRepository.new.create(answer_params.merge({survey_id: params[:survey_id], user_id: params[:user_id]}))

    if answer.success?
      render json: AnswerSerializer.new(answer.success.first).serializable_hash.to_json, status: 200
    else
      render json: answer.failure, status: 422
    end
  end

  # DELETE /surveys/survey_uuid_id/answers/uuid_id
  def destroy
    AnswerRepository.new.destroy(params[:id])
    render json: {}, status: 200
  end

  private

  def set_survey
    @survey = Survey.find(params[:survey_id])
  end

  def answer_params
    params.require(:answer).permit(:user_id, :answers_count, answer_data: [:number, :result])
  end
end

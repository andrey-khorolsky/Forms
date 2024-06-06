class AnswersController < ApplicationController
  # before_action :authenticate_user!
  before_action :set_survey, only: [:index, :show, :create]

  # GET /surveys/survey_uuid_id/answers
  def index
    # authorize! @survey, to: :index_answer?
    render json: AnswerSerializer.new(@survey.answers).serializable_hash.to_json
  end

  # GET /surveys/survey_uuid_id/answers/uuid_id
  def show
    answer = @survey.answers.find(params[:id])
    # authorize! answer

    render json: AnswerSerializer.new(answer).serializable_hash.to_json
  end

  # POST /surveys/survey_uuid_id/answers
  def create
    # authorize! @survey, to: :create_answer?

    unless @survey.can_user_answer?(User.last.id)
      render json: {message: "User has answered the allowed number of times"}, status: 405
    end

    answer = AnswerRepository.new.create(answer_params.merge({survey_id: params[:survey_id], user_id: User.last.id}))

    if answer.success?
      render json: AnswerSerializer.new(answer.success.first).serializable_hash.to_json, status: 200
    else
      render json: answer.failure, status: 422
    end
  end

  # DELETE /surveys/survey_uuid_id/answers/uuid_id
  def destroy
    # authorize! Answer.find(params[:id])

    AnswerRepository.new.destroy(params[:id])
    render json: {}, status: 200
  end

  private

  def set_survey
    @survey = Survey.find(params[:survey_id])
  end

  def answer_params
    params.require(:answer).permit(:answers_count, answer_data: [:number, :result])
  end
end

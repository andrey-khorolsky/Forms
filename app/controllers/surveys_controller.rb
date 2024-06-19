class SurveysController < PaginationController
  # before_action :authenticate_user!

  # GET /surveys
  def index
    # authorize! Survey

    @pagy, @records = pagy(Survey.where(question_mongo_id: Question.all.map(&:id)))
    render json: SurveySerializer.new(@records).serializable_hash
  end

  # GET /surveys/98e17521-56d6-4ecc-a903-091ff4a387c5
  def show
    survey = Survey.find(params[:id])
    # authorize! survey

    render json: SurveySerializer.new(survey).serializable_hash
  end

  # POST /surveys
  def create
    # authorize! Survey

    survey = SurveyRepository.new.create(survey_params, User.last)

    if survey.success?
      render json: SurveySerializer.new(survey.success.first).serializable_hash
    else
      render json: survey.failure, status: 422
    end
  end

  # DELETE /surveys/98e17521-56d6-4ecc-a903-091ff4a387c5
  def destroy
    # authorize! Survey.find(params[:id])

    SurveyRepository.new.destroy(params[:id])
    render json: {}, status: 200
  end

  private

  def survey_params
    params.require(:survey).permit(
      :name, :description, :private, :anonymous, :completion_time, :completion_by_person, :start_date, :end_date,
      :needed_votes, :actived, :questions_count, :wallpaper, questions: [
        :id, :number, :type, :text, subform: [
          :id, :number, :text
        ]
      ]
    )
  end
end

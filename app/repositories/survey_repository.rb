class SurveyRepository
  include Dry::Monads[:result]

  def create(params, user)
    params_result = SurveyParamsContract.new.call(params.to_h)
    return Failure(params_result.errors.messages.to_json) unless params_result.success?

    ActiveRecord::Base.transaction do
      question_params = {questions_count: params[:questions_count], questions: params[:questions]&.map(&:to_h)}
      @question = Question.new(question_params)
      return Failure(@question.errors.messages.to_json) unless @question.save

      survey_params = params.except(:questions, :questions_count).merge({question_mongo_id: @question.id.to_s})
      @survey = Survey.new(survey_params)
      return Failure(@survey.errors.messages.to_json) unless @survey.save

      AddPermissionService.add_admin(@survey, user)
    end

    Success([@survey, @question])
  end

  def destroy(survey_id)
    survey = Survey.find(survey_id)
    survey.question.destroy
    survey.destroy
  end
end

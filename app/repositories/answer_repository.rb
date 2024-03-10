class AnswerRepository
  include Dry::Monads[:result]

  def create(params)
    params_result = AnswerParamsContract.new.call(params.to_h)
    return Failure(params_result.errors.messages.to_json) unless params_result.success?

    answer_data_params = {answers_count: params[:answers_count], answer_data: params[:answer_data]&.map(&:to_h)}
    answer_data = AnswerDatum.new(answer_data_params)
    return Failure(answer_data.errors.messages.to_json) unless answer_data.save

    answer_params = {survey_id: params[:survey_id], answer_id: answer_data.id.to_s, user_id: params[:user_id]}
    answer = Answer.new(answer_params)
    unless answer.save
      answer_data.destroy
      return Failure(answer.errors.messages.to_json)
    end

    Success([answer, answer_data])
  end

  def destroy(answer_id)
    answer = Answer.find(answer_id)
    answer.answer_data.destroy
    answer.destroy
  end
end

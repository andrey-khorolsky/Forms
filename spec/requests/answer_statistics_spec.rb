require "swagger_helper"

RSpec.describe "answer_statistics", type: :request do
  let(:user) { create(:user) }
  let(:survey) { create(:survey, question_mongo_id: question.id) }
  let!(:answer) { create(:answer, :with_answer_data, survey_id: survey.id, user: user, answer_mongo_id: answer_data.id) }
  let(:answer_data) { create(:answer_datum) }
  let!(:question) { create(:question) }
  let(:role) { create(:role, :manager) }
  let!(:permission) { create(:permission, role: role, owner: user, entity: survey) }

  before { sign_in user }

  path "/surveys/{survey_id}/answer_statistics" do
    parameter name: "survey_id", in: :path, type: :string, description: "survey_id"
    parameter name: "date_from", in: :body, type: :string, description: "from this date statistics will be collected"
    parameter name: "date_to", in: :body, type: :string, description: "to this date statistics will be collected"
    parameter name: "except_question_numbers", in: :body, type: :string, description: "numbers of questions, that are not included in statistics"

    get("show answer_statistic") do
      response(200, "successful") do
        let(:survey_id) { survey.id }

        run_test!
      end
    end
  end
end

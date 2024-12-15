require "swagger_helper"

RSpec.describe "answer_statistics", type: :request do
  let(:user) { create(:user) }
  let(:survey) { create(:survey, question_mongo_id: question.id) }
  let!(:answer) do
    create(:answer, :with_answer_data,
    survey_id: survey.id,
    user: user,
    answer_mongo_id: answer_data.id,
    created_at: creation_date)
  end
  let(:answer_data) { create(:answer_datum) }
  let(:question) { create(:question) }
  let(:role) { create(:role, :manager) }
  let!(:permission) { create(:permission, role: role, owner: user, entity: survey) }
  let(:creation_date) { Date.new(2024, 12, 15)}

  before { sign_in user }

  path "/surveys/{survey_id}/answer_statistics" do
    parameter name: "survey_id", in: :path, type: :string, description: "id of survey"
    parameter name: "date_from", in: :query, type: :string, description: "from this date statistics will be collected"
    parameter name: "date_to", in: :query, type: :string, description: "to this date statistics will be collected"
    parameter name: "except_question_numbers", in: :query, type: :string, description: "numbers of questions, that are not included in statistics"

    get("show answer_statistic") do
      let(:date_from) { creation_date }
      let(:date_to) { creation_date }
      let(:except_question_numbers) { "1,2,3" }

      response(200, "successful") do
        let(:survey_id) { survey.id }
        produces "application/json; charset=utf-8"

        run_test!
      end

      response(404, "not found") do
        let(:survey_id) { "invalid-id" }
        produces "application/json; charset=utf-8"

        run_test!
      end
    end
  end
end

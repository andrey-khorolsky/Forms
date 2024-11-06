require "swagger_helper"

RSpec.describe "answer_spreadsheets", type: :request do
  let(:user) { create(:user) }
  let(:survey) { create(:survey, question_mongo_id: create(:question).id) }
  let!(:answer) { create(:answer, :with_answer_data, survey: survey, user: user) }
  let!(:permission) { create(:permission, :with_manager_role, owner: user, entity: survey) }

  before { sign_in user }
  after { DatabaseCleaner.clean }

  path "/surveys/{survey_id}/answer_spreadsheet{format}" do
    parameter name: "survey_id", in: :path, type: :string, description: "survey's ID"
    parameter name: "format", in: :path, type: :string, description: "format of response"

    let(:survey_id) { survey.id }

    get("show answer_spreadsheet") do
      response(200, "send xlsx file") do
        produces "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"

        let(:format) { ".xlsx" }

        run_test! do |response|
          expect(response.content_type).to eq "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
        end
      end

      response(200, "send csv file") do
        produces "text/csv"

        let(:format) { ".csv" }

        run_test! do |response|
          expect(response.content_type).to eq "text/csv"
        end
      end

      response(200, "send xml file") do
        produces "text/xml"

        let(:format) { ".xml" }

        run_test! do |response|
          expect(response.content_type).to eq "text/xml"
        end
      end

      response(400, "incorrect format") do
        produces "application/json; charset=utf-8"

        let(:format) { ".example" }

        run_test! do |response|
          expect(response.content_type).to eq "application/json; charset=utf-8"
        end
      end

      response(404, "survey not found") do
        produces "application/json; charset=utf-8"

        let(:survey_id) { "bad_id" }
        let(:format) { ".xlsx" }

        run_test! do |response|
          expect(response.content_type).to eq "application/json; charset=utf-8"
        end
      end
    end
  end
end

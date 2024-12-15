require "swagger_helper"

RSpec.describe "answer_spreadsheets", type: :request do
  let(:user) { create(:user) }
  let(:survey) { create(:survey, question_mongo_id: create(:question).id) }
  let!(:answer) { create(:answer, :with_answer_data, survey: survey, user: user) }
  let!(:permission) { create(:permission, :with_manager_role, owner: user, entity: survey) }

  before { sign_in user }
  after { DatabaseCleaner.clean }

  path "/surveys/{survey_id}/answer_spreadsheet" do
    parameter name: "survey_id", in: :path, type: :string, description: "survey's ID"
    parameter name: :format, in: :query, type: :string, description: "format of file (xlsx, csv, ods, xml, yaml)"

    let(:survey_id) { survey.id }
    let(:format) { "xml" }
    
    get("show answer_spreadsheet") do
      response(200, "sends file") do
        produces "text/xml", "text/csv", "application/yaml", "application/vnd.oasis.opendocument.spreadsheet",
          "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
        
        run_test!
      end

      response(400, "incorrect format") do
        let(:format) { "asd" }
        produces "application/json; charset=utf-8"

        run_test!
      end

      response(404, "survey not found") do
        let(:survey_id) { "bad_id" }

        produces "application/json; charset=utf-8"

        run_test! do |response|
          expect(response.content_type).to eq "application/json; charset=utf-8"
        end
      end
    end
  end
end

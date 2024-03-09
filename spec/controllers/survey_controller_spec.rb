require "rails_helper"

RSpec.describe SurveysController, type: :controller do
  describe "GET index" do
    context "all right" do
      let!(:survey) { create(:survey, question_id: question.id.to_s) }
      let(:question) { Question.create(questions: [{number: 1, text: "all right", type: "checkbox"}], questions_count: 1) }
      let(:all_surveys) { SurveySerializer.new(Survey.all).serializable_hash.to_json }

      before { get :index }

      it { should respond_with 200 }
      it { expect(response.body).to eq all_surveys }
    end
  end

  describe "GET show" do
    context "when survey exists" do
      let!(:survey) { create(:survey, question_id: question.id.to_s) }
      let(:question) { Question.create(questions: [{number: 1, text: "all right", type: "checkbox"}], questions_count: 1) }
      let(:survey_response) { SurveySerializer.new(Survey.find(survey.id)).serializable_hash.to_json }

      before { get :show, params: {id: survey.id} }

      it { should respond_with 200 }
      it { expect(response.body).to eq survey_response }
    end

    context "when survey not exists" do
      before { get :show, params: {id: "survey.id"} }

      it { should respond_with 404 }
    end
  end

  describe "POST create" do
    before { DatabaseCleaner.clean }

    context "when send correct params" do
      let(:survey_response) { SurveySerializer.new(Survey.find(Survey.last.id)).serializable_hash.to_json }
      let(:create_params) do
        {
          survey: {
            name: "second survey",
            questions_count: 2,
            questions: [
              {
                number: 1,
                type: "text",
                text: "fav artist?",
                required: true
              },
              {
                number: 2,
                type: "text",
                text: "fav song?"
              }
            ]
          }
        }
      end

      it "create survey and return json" do
        expect(Survey.count).to eq 0
        expect(Question.count).to eq 0

        post :create, params: create_params

        expect(Survey.count).to eq 1
        expect(Question.count).to eq 1
        expect(Survey.last.question).not_to eq nil

        should respond_with 200
        expect(response.body).to eq survey_response
      end
    end

    context "when send invalid params" do
      let(:error_message) { "\"text\":\"is missing\",\"path\":[\"questions\"]," }
      let(:create_params) do
        {
          survey: {
            name: "second survey",
            questions_count: 1
          }
        }
      end

      it "not create survey and return json with error" do
        expect(Survey.count).to eq 0
        expect(Question.count).to eq 0

        post :create, params: create_params

        expect(Survey.count).to eq 0
        expect(Question.count).to eq 0

        should respond_with 422
        expect(response.body).to include error_message
      end
    end
  end

  describe "DELETE destroy" do
    context "when survey exists" do
      let!(:survey) { create(:survey, question_id: question.id.to_s) }
      let(:question) { Question.create(questions: [{number: 1, text: "all right", type: "checkbox"}], questions_count: 1) }

      it "delete survey and questions" do
        expect(Survey.count).to eq 1
        expect(Question.count).to eq 1

        delete :destroy, params: {id: survey.id}

        expect(Survey.count).to eq 0
        expect(Question.count).to eq 0

        should respond_with 200
        expect(response.body).to eq "{}"
      end
    end

    context "when survey not exists" do
      before { delete :destroy, params: {id: "survey.id"} }

      it { should respond_with 404 }
    end
  end
end

require "rails_helper"

RSpec.describe AnswersController, type: :controller do
  let(:user) { create(:user) }
  let(:survey) { create(:survey) }

  before { DatabaseCleaner.clean }

  describe "GET index" do
    context "when all right" do
      let(:all_answers) { AnswerSerializer.new(Answer.all).serializable_hash.to_json }
      let(:answer_data_1) { create(:answer_datum) }
      let(:answer_data_2) { create(:answer_datum) }

      before do
        create(:answer, answer_id: answer_data_1.id, survey_id: survey.id, user_id: user.id)
        create(:answer, answer_id: answer_data_2.id, survey_id: survey.id, user_id: user.id)
      end

      it "returns all answers for survey" do
        get :index, params: {survey_id: survey.id}

        should respond_with 200
        expect(response.body).to eq all_answers
      end
    end
  end

  describe "GET show" do
    context "when answer exists" do
      let(:all_answers) { AnswerSerializer.new(Answer.all).serializable_hash.to_json }
      let(:answer_data) { create(:answer_datum) }
      let(:answer) { create(:answer, answer_id: answer_data.id, survey_id: survey.id, user_id: user.id) }
      let(:answer_response) { AnswerSerializer.new(Answer.find(answer.id)).serializable_hash.to_json }

      it "return json with answer" do
        get :show, params: {survey_id: survey.id, id: answer.id}

        should respond_with 200
        expect(response.body).to eq answer_response
      end
    end

    context "when survey not exists" do
      before { get :show, params: {survey_id: "survey.id", id: "answer.id"} }

      it { should respond_with 404 }
    end

    context "when answer not exists" do
      before { get :show, params: {survey_id: survey.id, id: "answer.id"} }

      it { should respond_with 404 }
    end
  end

  describe "POST create" do
    context "when send correct params" do
      let!(:create_params) do
        {
          survey_id: survey.id,
          user_id: user.id,
          answer: {
            answers_count: 2,
            answer_data: [
              {
                number: 1,
                result: "Answer for 1st question"
              },
              {
                number: 2,
                result: "And for 2nd"
              }
            ]
          }
        }
      end
      let(:answer_response) { AnswerSerializer.new(Answer.last).serializable_hash.to_json }

      it "create answer and return json" do
        expect(Survey.count).to eq 1
        expect(Answer.count).to eq 0
        expect(AnswerDatum.count).to eq 0

        post :create, params: create_params

        expect(Survey.count).to eq 1
        expect(Answer.count).to eq 1
        expect(AnswerDatum.count).to eq 1

        expect(Answer.last.answer_data).not_to eq nil
        expect(Survey.last.answers.count).to eq 1

        should respond_with 200
        expect(response.body).to eq answer_response
      end
    end

    context "when send invalid params" do
      let!(:create_params) do
        {
          survey_id: survey.id,
          user_id: user.id,
          answer: {
            answers_count: 2,
            answer_data: [
              {
                number: 1,
                result: "Answer for 1st question"
              }
            ]
          }
        }
      end
      let(:error_message) { "{\"answer_data\":[\"[:answer_data] Expected answers count and actual answers count not matches\"]}" }

      it "do not create survey and return json with error" do
        expect(Survey.count).to eq 1
        expect(Answer.count).to eq 0
        expect(AnswerDatum.count).to eq 0

        post :create, params: create_params

        expect(Survey.count).to eq 1
        expect(Answer.count).to eq 0
        expect(AnswerDatum.count).to eq 0

        should respond_with 422
        expect(response.body).to include error_message
      end
    end
  end

  describe "DELETE destroy" do
    context "when answer exists" do
      let!(:answer) { create(:answer, answer_id: answer_data.id, survey_id: survey.id, user_id: user.id) }
      let(:answer_data) { create(:answer_datum) }

      it "delete answer and answer_data" do
        expect(Survey.count).to eq 1
        expect(Answer.count).to eq 1
        expect(AnswerDatum.count).to eq 1

        delete :destroy, params: {survey_id: survey.id, id: answer.id}

        expect(Survey.count).to eq 1
        expect(Answer.count).to eq 0
        expect(AnswerDatum.count).to eq 0

        should respond_with 200
        expect(response.body).to eq "{}"
      end
    end

    context "when survey not exists" do
      before { delete :destroy, params: {survey_id: "survey.id", id: "answer.id"} }

      it { should respond_with 404 }
    end

    context "when answer not exists" do
      before { delete :destroy, params: {survey_id: survey.id, id: "answer.id"} }

      it { should respond_with 404 }
    end
  end
end

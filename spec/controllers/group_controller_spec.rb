require "rails_helper"

RSpec.describe GroupsController, type: :controller do
  describe "GET index" do
    context "all right" do
      before { 3.times { create(:group) } }

      it "return json with all groups" do
        get :index

        should respond_with 200
        expect(response.body).to eq GroupSerializer.new(Group.all).serializable_hash.to_json
      end
    end
  end

  describe "GET show" do
    context "when group exists" do
      let!(:group) { create(:group) }

      it "return json with group" do
        get :show, params: {id: group.id}

        should respond_with 200
        expect(response.body).to eq GroupSerializer.new(Group.find(group.id)).serializable_hash.to_json
      end
    end

    context "when group not exists" do
      before { get :show, params: {id: "group.id"} }

      it { should respond_with 404 }
    end
  end

  describe "POST create" do
    context "when send correct params" do
      let(:group_response) { GroupSerializer.new(Group.find(Group.last.id)).serializable_hash.to_json }
      let(:create_params) do
        {
          group: {
            name: "best group chili pepper"
          }
        }
      end

      it "create group and return json" do
        expect(Group.count).to eq 0

        post :create, params: create_params

        expect(Group.count).to eq 1

        should respond_with 200
        expect(response.body).to eq group_response
      end
    end

    context "when send invalid params" do
      let(:error_message) { "{\"name\":[\"can't be blank\"]}" }
      let(:create_params) do
        {
          group: {
            name: nil
          }
        }
      end

      it "not create group and return json with error" do
        expect(Group.count).to eq 0

        post :create, params: create_params

        expect(Group.count).to eq 0

        should respond_with 422
        expect(response.body).to include error_message
      end
    end
  end

  describe "PATCH/PUT update" do
    context "when method is PATCH" do
      context "when group exists" do
        let!(:group) { create(:group, name: old_name) }
        let(:old_name) { "old name" }
        let(:new_name) { "new name" }

        it "update group and return json with updated group" do
          expect(Group.count).to eq 1
          expect(Group.first.name).to eq old_name

          patch :update, params: {id: group.id, group: {name: new_name}}

          should respond_with 200
          expect(Group.count).to eq 1
          expect(Group.first.name).to eq new_name
          expect(response.body).to eq GroupSerializer.new(Group.find(group.id)).serializable_hash.to_json
        end
      end

      context "when group not exists" do
        before { patch :update, params: {id: "group.id", group: {name: "new_name"}} }

        it { should respond_with 404 }
      end
    end

    context "when method is PUT" do
      context "when group exists" do
        let!(:group) { create(:group, name: old_name) }
        let(:old_name) { "old name" }
        let(:new_name) { "new name" }

        it "update group and return json with updated group" do
          expect(Group.count).to eq 1
          expect(Group.first.name).to eq old_name

          put :update, params: {id: group.id, group: {name: new_name}}

          should respond_with 200
          expect(Group.count).to eq 1
          expect(Group.first.name).to eq new_name
          expect(response.body).to eq GroupSerializer.new(Group.find(group.id)).serializable_hash.to_json
        end
      end

      context "when group not exists" do
        before { put :update, params: {id: "group.id", group: {name: "new_name"}} }

        it { should respond_with 404 }
      end
    end
  end

  describe "DELETE destroy" do
    context "when group exists" do
      let!(:group) { create(:group) }

      it "delete group and questions" do
        expect(Group.count).to eq 1

        delete :destroy, params: {id: group.id}

        expect(Group.count).to eq 0

        should respond_with 200
        expect(response.body).to eq "{}"
      end
    end

    context "when group not exists" do
      before { delete :destroy, params: {id: "group.id"} }

      it { should respond_with 404 }
    end
  end
end

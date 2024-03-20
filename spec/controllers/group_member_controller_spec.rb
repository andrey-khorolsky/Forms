require "rails_helper"

RSpec.describe GroupMembersController, type: :controller do
  let(:group) { create(:group) }

  describe "GET index" do
    context "when all right" do
      let(:group_m) { create(:group) }
      let(:user) { create(:user) }

      before do
        create(:group_member, group: group, member: user)
        create(:group_member, group: group, member: group_m)
      end

      it "return json with all members in the group" do
        get :index, params: {group_id: group.id}

        should respond_with 200
        expect(response.body).to eq GroupMemberSerializer.new(GroupMember.all).serializable_hash.to_json
      end
    end
  end

  describe "GET show" do
    context "when group exists" do
      let(:user) { create(:user) }
      let(:group_member) { create(:group_member, group: group, member: user) }

      it "return json with group_member" do
        get :show, params: {group_id: group.id, id: group_member.id}

        should respond_with 200
        expect(response.body).to eq GroupMemberSerializer.new(GroupMember.find(group_member.id), include: [:member]).serializable_hash.to_json
      end
    end

    context "when group not exists" do
      before { get :show, params: {group_id: "group.id", id: "group_member.id"} }

      it { should respond_with 404 }
    end

    context "when group_member not exists" do
      before { get :show, params: {group_id: group.id, id: "group_member.id"} }

      it { should respond_with 404 }
    end
  end

  describe "POST create" do
    context "when send correct params" do
      let(:user) { create(:user) }
      let(:group_member_response) { GroupMemberSerializer.new(GroupMember.last).serializable_hash.to_json }
      let(:create_params) do
        {
          group_id: group.id,
          group_member: {
            member_id: user.id
          }
        }
      end

      it "add member to group and return json" do
        expect(GroupMember.count).to eq 0

        post :create, params: create_params

        expect(GroupMember.count).to eq 1

        should respond_with 200
        expect(response.body).to eq group_member_response
      end
    end

    context "when member already in the group" do
      let!(:group_member) { create(:group_member, group: group, member: user) }
      let(:user) { create(:user) }
      let(:error_message) { "{\"member_id\":[\"Member already in the Group\"]}" }
      let(:create_params) do
        {
          group_id: group.id,
          group_member: {
            member_id: user.id
          }
        }
      end

      it "do not add member to group and return json with error" do
        expect(GroupMember.count).to eq 1

        post :create, params: create_params

        expect(GroupMember.count).to eq 1

        should respond_with 422
        expect(response.body).to eq error_message
      end
    end

    # transitive dependency A -> B, B -> C, if C -> A => A -> A
    context "when member transitively dependent to group" do
      let(:user) { create(:user) }
      let(:nested_group_1) { create(:group) }
      let(:nested_group_2) { create(:group) }
      let(:error_message) { "{\"group_id\":[\"A target group also contains member group. Maybe throug another group\"]}" }
      let(:create_params) do
        {
          group_id: nested_group_2.id,
          group_member: {
            member_id: group.id
          }
        }
      end

      before do
        create(:group_member, group: group, member: user)
        create(:group_member, group: group, member: nested_group_1)
        create(:group_member, group: nested_group_1, member: user)
        create(:group_member, group: nested_group_1, member: nested_group_2)
      end

      it "do not add group(member) to group and return json with error" do
        expect(GroupMember.count).to eq 4

        post :create, params: create_params

        expect(GroupMember.count).to eq 4

        should respond_with 422
        expect(response.body).to include error_message
      end
    end

    context "when send invalid params" do
      let(:error_message) { "{\"error\":\"Not found\",\"entities\":[{\"group_id\":\"#{group.id}\"" }
      let(:create_params) do
        {
          group_id: group.id,
          group_member: {
            member_id: nil
          }
        }
      end

      it "do not add member to group and return json with error" do
        expect(GroupMember.count).to eq 0

        post :create, params: create_params

        expect(GroupMember.count).to eq 0

        should respond_with 404
        expect(response.body).to include error_message
      end
    end
  end

  describe "DELETE destroy" do
    context "when group exists" do
      let!(:group_member) { create(:group_member, group: group, member: user) }
      let(:user) { create(:user) }

      it "delete group_member" do
        expect(GroupMember.count).to eq 1

        delete :destroy, params: {group_id: group.id, id: group_member.id}

        expect(GroupMember.count).to eq 0

        should respond_with 200
        expect(response.body).to eq "{}"
      end
    end

    context "when group not exists" do
      before { delete :destroy, params: {group_id: "group.id", id: "group.id"} }

      it { should respond_with 404 }
    end

    context "when group_member not exists" do
      before { delete :destroy, params: {group_id: group.id, id: "group.id"} }

      it { should respond_with 404 }
    end
  end
end

class GroupMembersController < ApplicationController
  before_action :set_group

  # GET /groups/group_uuid_id/group_members
  def index
    render json: GroupMemberSerializer.new(@group.group_members).serializable_hash.to_json
  end

  # GET /groups/group_uuid_id/group_members/uuid_id
  def show
    # group_member_id or user_id? (now group_member_id)
    group_member = @group.group_members.find(params[:id])
    render json: GroupMemberSerializer.new(group_member, include: [:member]).serializable_hash.to_json
  end

  # POST /groups/group_uuid_id/group_members
  def create
    member_type = {}

    if group_member_params[:member_type].nil?
      if User.where(id: group_member_params[:member_id]).present?
        member_type = {member_type: "User"}
      elsif Group.where(id: group_member_params[:member_id]).present?
        member_type = {member_type: "Group"}
      else
        raise ActiveRecord::RecordNotFound
      end
    end

    group_member = @group.group_members.new(group_member_params.merge(member_type.compact))
    if group_member.save
      render json: GroupMemberSerializer.new(group_member).serializable_hash.to_json, status: 200
    else
      render json: group_member.errors, status: 422
    end
  end

  # DELETE /groups/group_uuid_id/group_members/uuid_id
  def destroy
    @group.group_members.find(params[:id]).destroy
    render json: {}, status: 200
  end

  private

  def group_member_params
    params.require(:group_member).permit(:member_id, :member_type)
  end

  def set_group
    @group = Group.find(params[:group_id])
  end
end

class GroupsController < ApplicationController
  # GET /groups
  def index
    render json: GroupSerializer.new(Group.all).serializable_hash.to_json
  end

  # GET /groups/b285ce14-628d-4a31-aac3-7b731c7a6ca0
  def show
    render json: GroupSerializer.new(Group.find(params[:id])).serializable_hash.to_json
  end

  # POST /groups
  def create
    group = Group.new(group_params)

    if group.save
      render json: GroupSerializer.new(group).serializable_hash.to_json, status: 200
    else
      render json: group.errors, status: 422
    end
  end

  # PATCH/PUT /groups/b285ce14-628d-4a31-aac3-7b731c7a6ca0
  def update
    group = Group.find(params[:id])

    if group.update(group_params)
      render json: GroupSerializer.new(group).serializable_hash.to_json, status: 200
    else
      render json: group.errors, status: 422
    end
  end

  # DELETE /groups/b285ce14-628d-4a31-aac3-7b731c7a6ca0
  def destroy
    Group.find(params[:id]).destroy
    render json: {}, status: 200
  end

  private

  def group_params
    params.require(:group).permit(:name)
  end
end

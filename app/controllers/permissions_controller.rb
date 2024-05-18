class PermissionsController < ApplicationController
  def index
    permissions = get_entity.permissions_as_entity
    render json: PermissionSerializer.new(permissions, include: [:owner]).serializable_hash
  end

  def show
    permission = get_entity.permissions_as_entity.find(params[:id])
    render json: PermissionSerializer.new(permission, include: [:owner]).serializable_hash
  end

  def create
    permission = Permission.new(permission_params)

    if permission.save
      render json: PermissionSerializer.new(permission, include: [:owner]).serializable_hash, status: 200
    else
      render json: permission.errors, status: 422
    end
  end

  def update
    permission = get_entity.permissions_as_entity.find(params[:id])

    if permission.update(role_id: get_role_id)
      render json: PermissionSerializer.new(permission, include: [:owner]).serializable_hash, status: 200
    else
      render json: permission.errors, status: 422
    end
  end

  def destroy
    Permission.find(params[:id]).destroy
    render json: {}, status: 200
  end

  private

  def get_entity
    if params.key?(:survey_id)
      Survey.find(params[:survey_id])
    elsif params.key?(:group_id)
      Group.find(params[:group_id])
    else
      raise ActiveRecord::RecordNotFound
    end
  end

  def permission_params
    params.require(:permission).permit(:owner_type, :owner_id).merge({entity: get_entity, role_id: get_role_id})
  end

  def get_role_id
    Role.find_by_name(params[:permission][:role_name]).id
  end
end

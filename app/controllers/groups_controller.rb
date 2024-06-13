class GroupsController < PaginationController
  before_action :authenticate_user!
  before_action :set_group, only: [:show, :update, :destroy]

  # GET /groups
  def index
    authorize! Group

    @pagy, @records = pagy(Group.all)
    render json: GroupSerializer.new(@records).serializable_hash
  end

  # GET /groups/b285ce14-628d-4a31-aac3-7b731c7a6ca0
  def show
    authorize! @group

    render json: GroupSerializer.new(@group).serializable_hash
  end

  # POST /groups
  def create
    authorize! Group

    group = Group.new(group_params)

    ActiveRecord::Base.transaction do
      group.save
      group.add_admin(current_user)
    end

    return render json: GroupSerializer.new(group).serializable_hash, status: 200 if group.valid?
    render json: group.errors, status: 422
  end

  # PATCH/PUT /groups/b285ce14-628d-4a31-aac3-7b731c7a6ca0
  def update
    authorize! @group

    if @group.update(group_params)
      render json: GroupSerializer.new(@group).serializable_hash, status: 200
    else
      render json: @group.errors, status: 422
    end
  end

  # DELETE /groups/b285ce14-628d-4a31-aac3-7b731c7a6ca0
  def destroy
    authorize! @group

    @group.destroy
    render json: {}, status: 200
  end

  private

  def group_params
    params.require(:group).permit(:name)
  end

  def set_group
    @group = Group.find(params[:id])
  end
end

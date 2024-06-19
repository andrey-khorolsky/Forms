class GroupCreatorService
  def self.create_group_from_params(params, owner)
    new_group = Group.new

    ActiveRecord::Base.transaction do
      new_group = Group.create!(params)
      AddPermissionService.add_admin(new_group, owner)
    end

    new_group
  end
end

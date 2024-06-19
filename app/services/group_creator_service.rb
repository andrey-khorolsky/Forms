class GroupCreatorService
  def self.create_group_from_params(params, owner)
    ActiveRecord::Base.transaction do
      new_group = Group.create!(params)
      AddPermissionService.add_admin(new_group, owner)
    end

    new_group
  end
end

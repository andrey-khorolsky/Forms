class GroupCreatorService
  def self.create_group_from_params(params, owner)
    new_group = Group.new(params)

    ActiveRecord::Base.transaction do
      new_group.save!
      AddPermissionService.add_admin(new_group, owner)
    end

    new_group
  end
end

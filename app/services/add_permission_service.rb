class AddPermissionService
  def self.add_admin(object, user)
    add_owner(object, user, Role::ADMIN)
  end

  def self.add_manager(object, user)
    add_owner(object, user, Role::MANAGER)
  end

  def self.add_guest(object, user)
    add_owner(object, user, Role::GUEST)
  end

  class << self
    private

    def add_owner(object, user, role_name)
      role_id = Role.find_by_name(role_name).id
      Permission.create!(owner: user, entity: object, role_id: role_id)
    end
  end
end

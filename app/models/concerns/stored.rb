module Stored
  extend ActiveSupport::Concern

  included do
    has_many :permissions_as_entity, class_name: "Permission", as: :entity, dependent: :destroy
    has_many :owner_groups, through: :permissions_as_entity, source: :owner, source_type: "Group"
    has_many :owner_users, through: :permissions_as_entity, source: :owner, source_type: "User"

    def owners
      owner_groups + owner_users
    end

    def add_admin(user)
      add_owner(Role::ADMIN, user)
    end

    def add_manager(user)
      add_owner(Role::MANAGER, user)
    end

    def add_guest(user)
      add_owner(Role::GUEST, user)
    end

    private

    def add_owner(role_name, user)
      role_id = Role.find_by_name(role_name).id
      Permission.create!(owner: user, owner_type: user.class, entity: self, role_id: role_id)
    end
  end
end

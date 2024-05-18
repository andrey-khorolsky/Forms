module Stored
  extend ActiveSupport::Concern

  included do
    has_many :permissions_as_entity, class_name: "Permission", as: :entity, dependent: :destroy
    has_many :owner_groups, through: :permissions_as_entity, source: :owner, source_type: "Group"
    has_many :owner_users, through: :permissions_as_entity, source: :owner, source_type: "User"

    validates :permissions_as_entity, length: {minimum: 1}

    def owners
      owner_groups + owner_users
    end

    def add_admin
      add_owner(Role::ADMIN)
    end

    def add_manager
      add_owner(Role::MANAGER)
    end

    def add_guest
      add_owner(Role::GUEST)
    end

    private

    def add_owner(role_name)
      role_id = Role.find_by_name(role_name).id
      Permission.create!(owner: current_user, entity: self, role_id: role_id)
    end
  end
end

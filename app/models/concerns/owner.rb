module Owner
  extend ActiveSupport::Concern

  included do
    has_many :permissions_as_owner, class_name: "Permission", as: :owner
    has_many :entity_groups, through: :permissions_as_owner, source: :entity, source_type: "Group"
    has_many :entity_surveys, through: :permissions_as_owner, source: :entity, source_type: "Survey"

    has_many :roles, through: :permissions_as_owner

    def entities
      entity_groups + entity_surveys
    end

    def admin_for?(entity_id)
      role_for_entity?(entity_id) == Role::ADMIN
    end

    def manager_for?(entity_id)
      role_for_entity?(entity_id) == Role::MANAGER
    end

    def guest_for?(entity_id)
      role_for_entity?(entity_id) == Role::GUEST
    end

    def manager_or_admin?(entity_id)
      role_for_entity?(record.id).in?([Role::ADMIN, Role::MANAGER])
    end

    def role_for_entity?(entity_id)
      permissions_as_owner.find_by(entity_id: entity_id)&.role&.name
    end
  end
end

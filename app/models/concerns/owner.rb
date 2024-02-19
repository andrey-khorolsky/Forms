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
  end
end

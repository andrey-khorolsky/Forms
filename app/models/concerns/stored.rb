module Stored
  extend ActiveSupport::Concern

  included do
    has_many :permissions_as_entity, class_name: "Permission", as: :entity, dependent: :destroy
    has_many :owner_groups, through: :permissions_as_entity, source: :owner, source_type: "Group"
    has_many :owner_users, through: :permissions_as_entity, source: :owner, source_type: "User"

    def owners
      owner_groups + owner_users
    end
  end
end

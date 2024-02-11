class Permission < ApplicationRecord
  validates :owner_type, :owner_id, :entity_type, :entity_id, :role_id, presence: true
  validates :owner_id, uniqueness: {scope: [:entity_id, :role_id]}
  validates :owner_id, uniqueness: {scope: :entity_id}

  belongs_to :role
  belongs_to :owner, polymorphic: true
  belongs_to :entity, polymorphic: true
end

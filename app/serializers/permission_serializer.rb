class PermissionSerializer
  include JSONAPI::Serializer
  attributes :owner_type, :owner_id

  attribute :role_name do |object|
    object.role.name
  end

  belongs_to :owner, polymorphic: {User => :user, Group => :group}
end

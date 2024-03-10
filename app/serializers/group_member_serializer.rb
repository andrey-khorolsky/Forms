class GroupMemberSerializer
  include JSONAPI::Serializer
  attributes :member_type, :member_id, :group_id, :created_at

  belongs_to :member, polymorphic: true
  belongs_to :group
end

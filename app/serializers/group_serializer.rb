class GroupSerializer
  include JSONAPI::Serializer
  attributes :name, :created_at
end

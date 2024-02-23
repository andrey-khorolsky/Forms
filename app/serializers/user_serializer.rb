class UserSerializer
  include JSONAPI::Serializer
  attributes :name, :birthday, :created_at
end

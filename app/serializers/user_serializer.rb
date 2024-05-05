class UserSerializer
  include JSONAPI::Serializer
  attributes :name, :email, :birthday, :created_at

  has_many :answers
  has_many :groups

  has_many :entities do |object|
    object.entities
  end
end

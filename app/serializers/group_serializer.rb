class GroupSerializer
  include JSONAPI::Serializer
  attributes :name, :created_at

  has_many :groups

  has_many :members do |object|
    object.members
  end

  has_many :owners do |object|
    object.owners
  end

  has_many :entities do |object|
    object.entities
  end
end

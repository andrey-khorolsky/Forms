class Role < ApplicationRecord
  ADMIN = "Administrator"
  MANAGER = "Manager"
  GUEST = "Guest"

  validates :name, presence: true

  has_many :permissions
end

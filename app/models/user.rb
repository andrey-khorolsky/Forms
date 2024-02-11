class User < ApplicationRecord
  validates :name, presence: true

  has_many :group_members, as: :member
  has_many :groups, through: :group_members
end

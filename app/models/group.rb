class Group < ApplicationRecord
  include Owner
  include Stored
  include Participant

  validates :name, presence: true

  # get the members (users or groups)
  has_many :group_members, dependent: :destroy
  has_many :member_users, through: :group_members, source: :member, source_type: "User"
  has_many :member_groups, through: :group_members, source: :member, source_type: "Group"

  # get the all members (users and groups)
  def members
    member_users + member_groups
  end
end

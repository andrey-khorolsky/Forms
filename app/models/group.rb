class Group < ApplicationRecord
  validates :name, presence: true

  # get the members (users or groups)
  has_many :group_members
  has_many :member_users, through: :group_members, source: :member, source_type: "User"
  has_many :member_groups, through: :group_members, source: :member, source_type: "Group"

  # get the groups the object belongs to
  has_many :group_members_as_member, class_name: "GroupMember", as: :member
  has_many :groups, through: :group_members_as_member

  # get the all members (users and groups)
  def members
    member_users + member_groups
  end
end

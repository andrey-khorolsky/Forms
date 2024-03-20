class GroupMember < ApplicationRecord
  validates :member_id, :member_type, :group_id, presence: true
  validates :member_id, uniqueness: {scope: :group_id, message: "Member already in the Group"}
  validates :member_id, exclusion: {in: :group_id, message: "A group cannot be a member of itself"}
  validate :cycle_of_groups

  belongs_to :member, polymorphic: true
  belongs_to :group

  private

  # to validate that GroupB cannot contain GroupA, where GroupA contains (maybe through another groups) GroupB
  def cycle_of_groups
    return if member_type == "User"

    members = Group.find(member_id).member_groups

    members.each do |g|
      if g.id == group_id
        errors.add(:group_id, "A target group also contains member group. Maybe throug another group")
        break
      end

      members << g.member_groups
      members.delete(g)
    end
  end
end

module Participant
  extend ActiveSupport::Concern

  included do
    # get the groups that an object belongs to
    has_many :group_members_as_member, class_name: "GroupMember", as: :member, dependent: :destroy
    has_many :groups, through: :group_members_as_member
  end
end

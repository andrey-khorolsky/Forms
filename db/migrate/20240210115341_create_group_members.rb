class CreateGroupMembers < ActiveRecord::Migration[7.0]
  def change
    create_enum :mem_types, ["User", "Group"]

    create_table :group_members, id: :uuid, default: "gen_random_uuid()" do |t|
      t.enum :member_type, enum_type: :mem_types, null: false
      t.uuid :member_id, null: false
      t.references :group, type: :uuid, null: false

      t.timestamps
    end
  end
end

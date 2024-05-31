class CreateGroupMembers < ActiveRecord::Migration[7.0]
  def up
    create_enum :mem_types, ["User", "Group"]

    create_table :group_members, id: :uuid, default: "gen_random_uuid()" do |t|
      t.enum :member_type, enum_type: :mem_types, null: false
      t.uuid :member_id, null: false

      t.references :group, type: :uuid, null: false, foreign_key: true

      t.timestamps
    end

    add_index :group_members, [:member_id, :member_type]
  end

  def down
    drop_table :group_members

    execute <<-SQL
      DROP TYPE mem_types;
    SQL
  end
end

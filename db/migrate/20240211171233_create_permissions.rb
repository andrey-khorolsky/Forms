class CreatePermissions < ActiveRecord::Migration[7.0]
  def up
    create_enum :owner_names, ["User", "Group"]
    create_enum :entity_names, ["Survey", "Group"]

    create_table :permissions, id: :uuid, default: "gen_random_uuid()" do |t|
      t.enum :owner_type, enum_type: :owner_names, null: false
      t.uuid :owner_id, null: false

      t.enum :entity_type, enum_type: :entity_names, null: false
      t.uuid :entity_id, null: false

      t.references :role, type: :uuid, null: false

      t.timestamps
    end
  end

  def down
    drop_table :permissions

    execute <<-SQL
      DROP TYPE owner_names;
      DROP TYPE entity_names;
    SQL
  end
end

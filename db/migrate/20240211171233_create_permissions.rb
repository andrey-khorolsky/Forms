class CreatePermissions < ActiveRecord::Migration[7.0]
  def up
    create_enum :owner_names, ["User", "Group"]
    create_enum :entity_names, ["Survey", "Group"]

    create_table :permissions, id: :uuid, default: "gen_random_uuid()" do |t|
      t.enum :owner_type, enum_type: :owner_names, null: false
      t.uuid :owner_id, null: false

      t.enum :entity_type, enum_type: :entity_names, null: false
      t.uuid :entity_id, null: false

      t.references :role, type: :uuid, null: false, foreign_key: true

      t.timestamps
    end

    add_index :permissions, [:owner_id, :owner_type]
    add_index :permissions, [:entity_id, :entity_type]
  end

  def down
    drop_table :permissions

    execute <<-SQL
      DROP TYPE owner_names;
      DROP TYPE entity_names;
    SQL
  end
end

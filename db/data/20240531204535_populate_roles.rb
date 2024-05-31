# frozen_string_literal: true

class PopulateRoles < ActiveRecord::Migration[7.0]
  def up
    Role.create([{name: Role::ADMIN}, {name: Role::MANAGER}, {name: Role::GUEST}])
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end

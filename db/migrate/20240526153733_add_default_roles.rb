class AddDefaultRoles < ActiveRecord::Migration[7.0]
  def up
    Role.create([{name: Role::ADMIN}, {name: Role::MANAGER}, {name: Role::GUEST}])
  end

  def down
    Role.where(name: [Role::ADMIN, Role::MANAGER, Role::GUEST]).delete_all
  end
end

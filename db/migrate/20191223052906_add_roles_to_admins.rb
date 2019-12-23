class AddRolesToAdmins < ActiveRecord::Migration[6.0]
  def change
    add_column :admins, :superadmin_role, :boolean
    add_column :admins, :supervisor_role, :boolean
    add_column :admins, :user_role, :boolean
  end
end

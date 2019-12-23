class AddSuperadmin < ActiveRecord::Migration[6.0]
  def change
    Admin.create! do |u|
        u.email     = 'admin@admin.com'
        u.password  = '12345678'
        u.superadmin_role = true
    end
  end
end

class RolesUsersRemoveTimestamps < ActiveRecord::Migration
  def up
    remove_column :roles_users, :created_at
    remove_column :roles_users, :updated_at
  end

  def down
  end
end

class AddRolesUsersTimestampDefault < ActiveRecord::Migration
  def up
    execute 'ALTER TABLE roles_users ALTER COLUMN created_at SET DEFAULT NOW()'
    execute 'ALTER TABLE roles_users ALTER COLUMN updated_at SET DEFAULT NOW()'
  end

  def down
  end
end

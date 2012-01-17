class DropTableGroupsUsers < ActiveRecord::Migration
  def up
    drop_table :groups_users
  end

  def down
  end
end

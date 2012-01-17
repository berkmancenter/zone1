class DropTableGroupsOwners < ActiveRecord::Migration
  def up
    drop_table :groups_owners
  end

  def down
  end
end

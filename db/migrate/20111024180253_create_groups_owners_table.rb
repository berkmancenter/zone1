class CreateGroupsOwnersTable < ActiveRecord::Migration
  def change 
    create_table :groups_owners, :id => false do |t|
      t.references :group
      t.references :owner
    end
    add_index :groups_owners, :group_id
    add_index :groups_owners, :owner_id
  end
end

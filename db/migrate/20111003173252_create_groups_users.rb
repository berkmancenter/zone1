class CreateGroupsUsers < ActiveRecord::Migration
  def change
    create_table :groups_users, :id => false do |t|
      t.references :user
      t.references :group
    end
    add_index :groups_users, :user_id
    add_index :groups_users, :group_id
  end
end

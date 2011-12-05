class CreateRolesGroups < ActiveRecord::Migration
  def change
    create_table :roles_groups, :id => false do |t|
      t.references :group
      t.references :role
      t.timestamps
    end
    add_index :roles_groups, :group_id
    add_index :roles_groups, :role_id
  end
end

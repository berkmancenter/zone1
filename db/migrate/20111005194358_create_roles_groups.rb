class CreateRolesGroups < ActiveRecord::Migration
  def change
    create_table :roles_groups, :id => false do |t|
      t.references :group
      t.references :role
      t.timestamps
    end
  end
end

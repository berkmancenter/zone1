class CreateGroupsOwnersTable < ActiveRecord::Migration
  def change 
    create_table :groups_owners, :id => false do |t|
      t.references :group
      t.references :owner
    end
  end
end

class AddAssignableRightsToGroups < ActiveRecord::Migration
  def change
    add_column :groups, :assignable_rights, :boolean, :default => false
  end
end

class CreateGroupsStoredFiles < ActiveRecord::Migration
  def change
    create_table :groups_stored_files, :id => false do |t|
      t.references :group
      t.references :stored_file
    end
  end
end

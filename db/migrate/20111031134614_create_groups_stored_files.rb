class CreateGroupsStoredFiles < ActiveRecord::Migration
  def change
    create_table :groups_stored_files do |t|
      t.references :group
      t.references :stored_file
    end
    add_index :groups_stored_files, :group_id
    add_index :groups_stored_files, :stored_file_id
  end
end

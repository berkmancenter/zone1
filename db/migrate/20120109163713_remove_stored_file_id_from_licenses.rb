class RemoveStoredFileIdFromLicenses < ActiveRecord::Migration
  def up
    remove_column :licenses, :stored_file_id
  end

  def down
    add_column :licenses, :stored_file_id, :integer
  end
end

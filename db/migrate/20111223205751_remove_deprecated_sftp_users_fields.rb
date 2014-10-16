class RemoveDeprecatedSftpUsersFields < ActiveRecord::Migration
  def up
    remove_column :sftp_users, :active
    remove_index :sftp_users, :sftp_group_id
    remove_index :sftp_users, :user_id
  end

  def down
    add_column :sftp_users, :active, :boolean, :default => true
    add_index :sftp_users, :sftp_group_id
    add_index :sftp_users, :user_id
  end
end

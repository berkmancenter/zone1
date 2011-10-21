class CreateSftpUsers < ActiveRecord::Migration
  def up
    create_table :sftp_users, :id => false do |t|
      t.integer :user_id, :null => false
      t.string :username
      t.string :passwd
      t.integer :uid
      t.integer :sftp_group_id
      t.string :homedir
      t.string :shell
	  t.boolean :active

      t.timestamps
    end
	execute "ALTER TABLE sftp_users ADD PRIMARY KEY (user_id)"
  end

  def down
	drop_table :sftp_users
  end
end

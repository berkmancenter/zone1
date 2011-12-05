class CreateSftpUsers < ActiveRecord::Migration
  def change
    create_table :sftp_users, :id => false do |t|
      t.references :user, :null => false
      t.string :username
      t.string :passwd
      t.integer :uid
      t.references :sftp_group
      t.string :homedir
      t.string :shell
  	  t.boolean :active

      t.timestamps
    end
    add_index :sftp_users, :sftp_group_id
    add_index :sftp_users, :user_id
  	execute "ALTER TABLE sftp_users ADD PRIMARY KEY (user_id)"
  end
end

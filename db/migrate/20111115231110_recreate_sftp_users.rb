class RecreateSftpUsers < ActiveRecord::Migration
  #create a new table rather than tweak the old one
  def up
    drop_table :sftp_users
    create_table :sftp_users do |t|
      t.references :user, :null => false
      t.string :username, :null => false
      t.string :passwd, :null => false
      t.integer :uid
      t.integer :sftp_group_id
      t.string :homedir
      t.string :shell
      t.boolean :active, :default => true
      t.timestamps
    end
    add_index :sftp_users, :username
    add_index :sftp_users, :passwd
    add_index :sftp_users, :sftp_group_id
    add_index :sftp_users, :user_id
  end

  def down
    drop_table :sftp_users
  end

end

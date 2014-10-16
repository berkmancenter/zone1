class CreateSftpGroups < ActiveRecord::Migration
  def up
    create_table :sftp_groups, :id => false do |t|
	  t.integer :id
      t.string :name
      t.text :members

      t.timestamps
    end
	execute "ALTER TABLE sftp_groups ADD PRIMARY KEY (id)"	
  end

  def down
	drop_table :sftp_groups
  end
end

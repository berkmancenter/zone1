class ChangeLicenseColumn < ActiveRecord::Migration
  def up 
    add_column :stored_files, :license_id, :integer
  end

  def down
	remove_column :stored_files, :license_id
  end 
end

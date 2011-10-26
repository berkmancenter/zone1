class ChangeLicenseColumn < ActiveRecord::Migration
  def up 
	remove_column :stored_files, :license_id
    change_table :stored_files do |t|
	  t.references :license
	end 
  end

  def down
	remove_column :stored_files, :license_id
    add_column :stored_files, :license_id, :text
  end 
end

class DropFlagsStoredFiles < ActiveRecord::Migration
  def up
    drop_table :flags_stored_files
  end

  def down
	create_table :flags_stored_files, :id => false do |t|
	  t.integer :flag_id
	  t.integer :stored_file_id
	end
  end
end

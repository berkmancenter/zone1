class CreateFlagsStoredFiles < ActiveRecord::Migration
  def change 
	create_table :flags_stored_files, :id => false do |t|
		t.integer :flag_id
		t.integer :stored_file_id
	end
  end
end

class CreateFlagsStoredFiles < ActiveRecord::Migration
  def change 
    create_table :flags_stored_files, :id => false do |t|
      t.references :flag
      t.references :stored_file
    end
    add_index :flags_stored_files, :flag_id
    add_index :flags_stored_files, :stored_file_id
  end
end

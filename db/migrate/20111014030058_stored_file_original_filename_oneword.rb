class StoredFileOriginalFilenameOneword < ActiveRecord::Migration
  def up
    rename_column :stored_files, :original_file_name, :original_filename 
end

  def down
    rename_column :stored_files, :original_filename, :original_file_name 
  end
end

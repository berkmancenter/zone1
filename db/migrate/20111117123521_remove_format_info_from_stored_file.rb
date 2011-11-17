class RemoveFormatInfoFromStoredFile < ActiveRecord::Migration
  def change  
    remove_column :stored_files, :format_name
    remove_column :stored_files, :mime_type
    add_column :stored_files, :mime_type_id, :integer
  end
end

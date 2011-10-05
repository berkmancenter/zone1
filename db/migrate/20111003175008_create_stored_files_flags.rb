class CreateStoredFilesFlags < ActiveRecord::Migration
  def change
    create_table :stored_files_flags, :id => false do |t|
      t.references :stored_file
      t.references :flag
    end
  end
end

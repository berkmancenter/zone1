class AddFileToStoredFiles < ActiveRecord::Migration
  def change
    add_column :stored_files, :file, :string
  end
end
